-- =============================================================================
-- Live Y Dream - schéma de la base de données (version 1, à relire)
-- Moteur : PostgreSQL sur Supabase.
--
-- En clair
--   * Une table pour ce qui a un statut, une image ou un lien vers autre chose :
--     articles, campagnes, commentaires, médias, services, clients, offres d'emploi.
--   * Une seule table, site_content, pour les blocs de texte modifiés d'un coup
--     dans Réglages : coordonnées, à propos, tarifs, témoignages, textes des pages.
--   * Un visiteur lit ce qui est publié et peut déposer un commentaire, un message
--     ou une candidature. Il ne peut jamais relire ce qui a été déposé.
--   * Les droits suivent les rôles de l'admin : Super Admin, Admin, Éditeur.
--
-- Mise en place
--   1. Supabase > SQL Editor : coller ce fichier et l'exécuter une seule fois,
--      sur un projet vide. Tout passe ou rien ne passe.
--   2. Créer votre compte : le tout premier devient Super Admin.
--   3. Désactiver aussitôt les inscriptions publiques dans Authentication.
-- =============================================================================

begin;

-- -----------------------------------------------------------------------------
-- 1. Types
-- -----------------------------------------------------------------------------

create type public.user_role as enum ('super_admin', 'admin', 'editor');
create type public.content_status as enum ('draft', 'published');
-- Les onglets de la page Commentaires : En attente, Approuvés, Indésirable, Corbeille
create type public.comment_status as enum ('pending', 'approved', 'spam', 'trash');
create type public.request_status as enum ('new', 'read', 'archived');

create domain public.slug as text
  check (value ~ '^[a-z0-9]+(-[a-z0-9]+)*$');
create domain public.email_address as text
  check (char_length(value) <= 254 and value ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$');

-- -----------------------------------------------------------------------------
-- 2. Comptes
-- -----------------------------------------------------------------------------

-- Complète auth.users de Supabase, qui garde les mots de passe
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text not null unique,
  display_name text not null check (char_length(display_name) between 1 and 120),
  role public.user_role not null default 'editor',
  is_active boolean not null default false,
  must_change_password boolean not null default false,
  last_sign_in_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.activity_log (
  id bigint generated always as identity primary key,
  actor_id uuid references public.profiles (id) on delete set null,
  actor_name text not null default '',
  summary text not null check (char_length(summary) <= 500),
  created_at timestamptz not null default now()
);

-- -----------------------------------------------------------------------------
-- 3. Contenu éditorial
--    wp_id garde l'identifiant WordPress : la reprise des données pourra être
--    relancée sans créer de doublons.
-- -----------------------------------------------------------------------------

-- Le fichier est soit dans Supabase Storage, soit à une adresse externe
create table public.media (
  id uuid primary key default gen_random_uuid(),
  wp_id bigint unique,
  storage_path text unique,
  external_url text,
  file_name text not null,
  alt_text text not null default '',
  mime_type text,
  width integer check (width > 0),
  height integer check (height > 0),
  size_bytes bigint check (size_bytes >= 0),
  uploaded_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint media_has_one_source check (num_nonnulls(storage_path, external_url) = 1)
);

create table public.categories (
  id uuid primary key default gen_random_uuid(),
  wp_id bigint unique,
  slug public.slug not null unique,
  name text not null unique check (char_length(name) between 1 and 120),
  created_at timestamptz not null default now()
);

create table public.tags (
  id uuid primary key default gen_random_uuid(),
  wp_id bigint unique,
  slug public.slug not null unique,
  name text not null unique check (char_length(name) between 1 and 120),
  created_at timestamptz not null default now()
);

create table public.articles (
  id uuid primary key default gen_random_uuid(),
  wp_id bigint unique,
  slug public.slug not null unique,
  title text not null check (char_length(title) between 1 and 300),
  excerpt text not null default '',
  content_html text not null default '',
  status public.content_status not null default 'draft',
  is_featured boolean not null default false,
  allow_comments boolean not null default true,
  category_id uuid references public.categories (id) on delete set null,
  -- author_name reste affiché même si l'auteur n'a pas de compte (ex. « LiveYDream »)
  author_id uuid references public.profiles (id) on delete set null,
  author_name text not null default '',
  cover_media_id uuid references public.media (id) on delete set null,
  reading_minutes integer not null default 1 check (reading_minutes > 0),
  seo_title text not null default '',
  seo_description text not null default '',
  published_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  search tsvector generated always as (to_tsvector('french'::regconfig, title || ' ' || excerpt)) stored
);

create table public.article_tags (
  article_id uuid not null references public.articles (id) on delete cascade,
  tag_id uuid not null references public.tags (id) on delete cascade,
  primary key (article_id, tag_id)
);

create table public.comments (
  id uuid primary key default gen_random_uuid(),
  wp_id bigint unique,
  article_id uuid not null references public.articles (id) on delete cascade,
  -- Supprimer un commentaire garde ses réponses : elles remontent d'un niveau
  parent_id uuid references public.comments (id) on delete set null,
  author_name text not null check (char_length(author_name) between 1 and 120),
  author_email public.email_address not null,
  author_user_id uuid references public.profiles (id) on delete set null,
  content text not null check (char_length(content) between 1 and 5000),
  status public.comment_status not null default 'pending',
  previous_status public.comment_status,
  sender_ip inet,
  trashed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint comments_not_own_parent check (parent_id is null or parent_id <> id)
);

-- -----------------------------------------------------------------------------
-- 4. Portfolio et offres
-- -----------------------------------------------------------------------------

create table public.campaigns (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 300),
  client text not null,
  site_filter text not null check (site_filter in ('Digital', 'Vidéo & Photo', 'Événementiel', 'Identité')),
  category text not null default '',
  year_label text not null default '',
  description text not null default '',
  tags text[] not null default '{}',
  -- [{"value": "+340%", "label": "Engagement"}, ...]
  results jsonb not null default '[]' check (jsonb_typeof(results) = 'array'),
  cover_media_id uuid references public.media (id) on delete set null,
  status public.content_status not null default 'draft',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.services (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 200),
  short_name text not null,
  form_need text not null default '',
  summary text not null default '',
  description text not null default '',
  tags text[] not null default '{}',
  -- [{"title": "Reporting mensuel", "detail": "Résultats clairs..."}, ...]
  deliverables jsonb not null default '[]' check (jsonb_typeof(deliverables) = 'array'),
  price_label text not null default '',
  price text not null default '',
  cta_label text not null default 'Demander un devis',
  image_media_id uuid references public.media (id) on delete set null,
  image_label text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.clients (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 1 and 120),
  logo_media_id uuid references public.media (id) on delete set null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.jobs (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 200),
  contract_type text not null default '',
  location text not null default '',
  description text not null default '',
  status public.content_status not null default 'draft',
  posted_on date not null default current_date,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- -----------------------------------------------------------------------------
-- 5. Demandes des visiteurs (données personnelles : jamais publiques)
-- -----------------------------------------------------------------------------

create table public.contact_messages (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 1 and 120),
  company text not null default '' check (char_length(company) <= 200),
  email public.email_address not null,
  whatsapp text not null check (char_length(whatsapp) between 1 and 40),
  need text not null default '' check (char_length(need) <= 200),
  budget text not null default '' check (char_length(budget) <= 100),
  message text not null default '' check (char_length(message) <= 5000),
  status public.request_status not null default 'new',
  sender_ip inet,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.job_applications (
  id uuid primary key default gen_random_uuid(),
  job_id uuid references public.jobs (id) on delete set null,
  applied_for text not null check (char_length(applied_for) between 1 and 200),
  name text not null check (char_length(name) between 1 and 120),
  email public.email_address not null,
  whatsapp text not null check (char_length(whatsapp) between 1 and 40),
  cv_url text check (cv_url is null or (char_length(cv_url) <= 500 and cv_url ~* '^https?://')),
  message text not null default '' check (char_length(message) <= 5000),
  status public.request_status not null default 'new',
  sender_ip inet,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- -----------------------------------------------------------------------------
-- 6. Blocs de texte du site
--    Mêmes clés que dans js/cms.js : settings, contact, problems, plan, plans,
--    process, testimonials, careers, blogTexts, about, texts, seo.
--    is_public = false pour les réglages internes (ex. discussion).
-- -----------------------------------------------------------------------------

create table public.site_content (
  key text primary key check (key ~ '^[a-zA-Z]+$'),
  value jsonb not null,
  is_public boolean not null default true,
  updated_by uuid references public.profiles (id) on delete set null,
  updated_at timestamptz not null default now()
);

insert into public.site_content (key, value, is_public)
values ('discussion', '{"enabled": true, "moderate": true}', false);

-- -----------------------------------------------------------------------------
-- 7. Index
-- -----------------------------------------------------------------------------

-- Un seul article « à la une » à la fois
create unique index articles_one_featured on public.articles (is_featured) where is_featured;
create index articles_public_list on public.articles (status, published_at desc);
create index articles_category on public.articles (category_id);
create index articles_author on public.articles (author_id);
create index articles_cover on public.articles (cover_media_id);
create index articles_search on public.articles using gin (search);
create index article_tags_tag on public.article_tags (tag_id);

create index comments_inbox on public.comments (status, created_at desc);
create index comments_article on public.comments (article_id, status);
create index comments_parent on public.comments (parent_id);
create index comments_email on public.comments (author_email);
create index comments_ip_recent on public.comments (sender_ip, created_at);
create index comments_author_user on public.comments (author_user_id);

create index media_recent on public.media (created_at desc);
create index media_uploaded_by on public.media (uploaded_by);
create index campaigns_list on public.campaigns (status, sort_order);
create index campaigns_cover on public.campaigns (cover_media_id);
create index services_image on public.services (image_media_id);
create index clients_logo on public.clients (logo_media_id);
create index jobs_list on public.jobs (status, sort_order);

create index contact_messages_inbox on public.contact_messages (status, created_at desc);
create index contact_messages_ip_recent on public.contact_messages (sender_ip, created_at);
create index job_applications_inbox on public.job_applications (status, created_at desc);
create index job_applications_ip_recent on public.job_applications (sender_ip, created_at);
create index job_applications_job on public.job_applications (job_id);
create index activity_log_recent on public.activity_log (created_at desc);
create index activity_log_actor on public.activity_log (actor_id);
create index site_content_updated_by on public.site_content (updated_by);

-- -----------------------------------------------------------------------------
-- 8. Fonctions de droits
-- -----------------------------------------------------------------------------

create function public.has_role(variadic allowed public.user_role[])
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.profiles p
    where p.id = auth.uid() and p.is_active and p.role = any (allowed)
  );
$$;

create function public.is_staff()
returns boolean language sql stable set search_path = '' as $$
  select public.has_role('super_admin', 'admin', 'editor');
$$;

create function public.is_manager()
returns boolean language sql stable set search_path = '' as $$
  select public.has_role('super_admin', 'admin');
$$;

create function public.is_super_admin()
returns boolean language sql stable set search_path = '' as $$
  select public.has_role('super_admin');
$$;

-- -----------------------------------------------------------------------------
-- 9. Automatismes
-- -----------------------------------------------------------------------------

create function public.set_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

do $$
declare
  t text;
begin
  foreach t in array array['profiles', 'media', 'articles', 'comments', 'campaigns', 'services', 'clients', 'jobs', 'contact_messages', 'job_applications', 'site_content'] loop
    execute format('create trigger set_updated_at before update on public.%I for each row execute function public.set_updated_at()', t);
  end loop;
end;
$$;

-- Le premier compte devient Super Admin. Les suivants restent inactifs
-- jusqu'à ce qu'un Super Admin leur donne accès.
create function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  is_first boolean;
begin
  perform pg_advisory_xact_lock(hashtext('lyd_first_account'));
  select not exists (select 1 from public.profiles) into is_first;
  insert into public.profiles (id, email, display_name, role, is_active)
  values (
    new.id,
    new.email,
    coalesce(nullif(new.raw_user_meta_data ->> 'display_name', ''), split_part(new.email, '@', 1)),
    case when is_first then 'super_admin'::public.user_role else 'editor'::public.user_role end,
    is_first
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

create function public.sync_user_profile()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  update public.profiles
  set email = new.email, last_sign_in_at = new.last_sign_in_at
  where id = new.id;
  return new;
end;
$$;

create trigger on_auth_user_updated
  after update of email, last_sign_in_at on auth.users
  for each row execute function public.sync_user_profile();

-- Mêmes règles que la page Utilisateurs, garanties ici même si l'interface est contournée
create function public.protect_profile()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  caller uuid := auth.uid();
begin
  if tg_op = 'UPDATE' and caller is not null then
    if (new.role is distinct from old.role or new.is_active is distinct from old.is_active)
       and not public.is_super_admin() then
      raise exception 'Seul un Super Admin peut changer un rôle ou activer un compte.' using errcode = '42501';
    end if;
    if new.id = caller and not new.is_active then
      raise exception 'Vous ne pouvez pas désactiver votre propre compte.' using errcode = 'P0001';
    end if;
  end if;
  if old.role = 'super_admin' and old.is_active
     and (tg_op = 'DELETE' or new.role <> 'super_admin' or not new.is_active)
     and not exists (
       select 1 from public.profiles p
       where p.id <> old.id and p.role = 'super_admin' and p.is_active
     ) then
    raise exception 'Il doit rester au moins un Super Admin actif.' using errcode = 'P0001';
  end if;
  if tg_op = 'DELETE' then
    return old;
  end if;
  return new;
end;
$$;

create trigger protect_profile
  before update or delete on public.profiles
  for each row execute function public.protect_profile();

-- Adresse IP du visiteur, transmise par Supabase dans les en-têtes de la requête
create function public.client_ip()
returns inet language plpgsql stable set search_path = '' as $$
declare
  headers json;
begin
  headers := nullif(current_setting('request.headers', true), '')::json;
  return nullif(btrim(coalesce(headers ->> 'cf-connecting-ip', split_part(headers ->> 'x-forwarded-for', ',', 1))), '')::inet;
exception when others then
  return null;
end;
$$;

-- Vrai pour l'équipe et pour un import fait côté serveur (éditeur SQL, clé service) :
-- la reprise des données WordPress garde ainsi les états et les dates d'origine.
create function public.is_trusted_writer()
returns boolean language sql stable set search_path = '' as $$
  select public.is_staff() or coalesce(current_setting('role', true), 'none') not in ('anon', 'authenticated');
$$;

-- Anti-abus : note l'adresse IP et limite le nombre d'envois par heure (argument du trigger)
create function public.limit_visitor_submissions()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  recent integer;
begin
  if public.is_trusted_writer() then
    return new;
  end if;
  new.sender_ip := public.client_ip();
  if new.sender_ip is not null then
    execute format('select count(*) from %I.%I where sender_ip = $1 and created_at > now() - interval ''1 hour''', tg_table_schema, tg_table_name)
      into recent using new.sender_ip;
    if recent >= tg_argv[0]::integer then
      raise exception 'Trop d''envois depuis cette adresse, réessayez plus tard.' using errcode = 'P0001';
    end if;
  end if;
  return new;
end;
$$;

-- Un commentaire de visiteur suit les réglages de discussion, quoi qu'envoie le navigateur
create function public.prepare_comment()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  discussion jsonb;
  parent_article uuid;
  parent_status public.comment_status;
begin
  if new.parent_id is not null then
    select c.article_id, c.status into parent_article, parent_status
    from public.comments c where c.id = new.parent_id;
    if parent_article is distinct from new.article_id then
      raise exception 'Cette réponse ne correspond pas à cet article.' using errcode = '23514';
    end if;
  end if;

  if public.is_trusted_writer() then
    new.author_user_id := coalesce(new.author_user_id, auth.uid());
    return new;
  end if;

  select s.value into discussion from public.site_content s where s.key = 'discussion';
  if not coalesce((discussion ->> 'enabled')::boolean, true) then
    raise exception 'Les commentaires sont fermés.' using errcode = 'P0001';
  end if;
  if new.parent_id is not null and parent_status <> 'approved' then
    raise exception 'Cette réponse ne correspond pas à un commentaire publié.' using errcode = '23514';
  end if;

  new.status := case when coalesce((discussion ->> 'moderate')::boolean, true)
    then 'pending'::public.comment_status else 'approved'::public.comment_status end;
  new.author_user_id := null;
  new.previous_status := null;
  new.trashed_at := null;
  new.created_at := now();
  return new;
end;
$$;

-- Permet « Restaurer » et le vidage de la corbeille
create function public.track_comment_status()
returns trigger language plpgsql set search_path = '' as $$
begin
  if new.status is distinct from old.status then
    new.previous_status := old.status;
    new.trashed_at := case when new.status = 'trash' then now() end;
  end if;
  return new;
end;
$$;

-- Les triggers d'une table partent par ordre alphabétique : limite, puis préparation
create trigger comments_10_limit before insert on public.comments
  for each row execute function public.limit_visitor_submissions('10');
create trigger comments_20_prepare before insert on public.comments
  for each row execute function public.prepare_comment();
create trigger comments_track_status before update on public.comments
  for each row execute function public.track_comment_status();
create trigger contact_messages_limit before insert on public.contact_messages
  for each row execute function public.limit_visitor_submissions('5');
create trigger job_applications_limit before insert on public.job_applications
  for each row execute function public.limit_visitor_submissions('5');

-- Vide la corbeille et les indésirables, comme WordPress après 30 jours.
-- À planifier une fois pg_cron activé sur le projet :
--   select cron.schedule('vider-commentaires', '0 3 * * *', 'select public.purge_comments()');
create function public.purge_comments(older_than interval default interval '30 days')
returns integer language plpgsql set search_path = '' as $$
declare
  removed integer;
begin
  delete from public.comments
  where status in ('spam', 'trash') and coalesce(trashed_at, updated_at) < now() - older_than;
  get diagnostics removed = row_count;
  return removed;
end;
$$;

revoke execute on function public.purge_comments(interval) from public, anon, authenticated;

-- La bulle de la colonne « En réponse à » (le filtre de sécurité reste celui de comments)
create view public.article_comment_counts with (security_invoker = true) as
  select
    article_id,
    count(*) filter (where status = 'approved') as approved,
    count(*) filter (where status = 'pending') as pending
  from public.comments
  group by article_id;

-- -----------------------------------------------------------------------------
-- 10. Droits d'accès
--     Supabase ouvre par défaut toutes les tables aux visiteurs (anon) et aux
--     comptes connectés (authenticated). On ferme tout, puis on rouvre au cas par cas.
-- -----------------------------------------------------------------------------

do $$
declare
  t text;
begin
  foreach t in array array['profiles', 'activity_log', 'media', 'categories', 'tags', 'articles', 'article_tags', 'comments', 'campaigns', 'services', 'clients', 'jobs', 'contact_messages', 'job_applications', 'site_content'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('revoke all on table public.%I from anon, authenticated', t);
  end loop;
end;
$$;

revoke all on table public.article_comment_counts from anon, authenticated;
grant select on table public.article_comment_counts to authenticated;

-- Lecture publique du contenu
grant select on table public.categories, public.tags, public.article_tags, public.articles, public.campaigns, public.services, public.clients, public.jobs, public.site_content to anon, authenticated;
grant select (id, storage_path, external_url, alt_text, width, height) on table public.media to anon;

-- Écriture réservée aux comptes ; les règles ci-dessous précisent lesquels
grant select, insert, update, delete on table public.media, public.categories, public.tags, public.article_tags, public.articles, public.campaigns, public.services, public.clients, public.jobs, public.site_content, public.comments to authenticated;
grant select, update, delete on table public.contact_messages, public.job_applications to authenticated;
grant select, insert on table public.activity_log to authenticated;
grant select on table public.profiles to authenticated;
grant update (display_name, role, is_active, must_change_password) on table public.profiles to authenticated;

-- Ce qu'un visiteur peut envoyer et relire : l'email et l'adresse IP d'un commentaire restent inaccessibles
grant select (id, article_id, parent_id, author_name, content, created_at) on table public.comments to anon;
grant insert (article_id, parent_id, author_name, author_email, content) on table public.comments to anon;
grant insert (name, company, email, whatsapp, need, budget, message) on table public.contact_messages to anon, authenticated;
grant insert (job_id, applied_for, name, email, whatsapp, cv_url, message) on table public.job_applications to anon, authenticated;

-- Comptes
create policy "profils : équipe ou soi-même" on public.profiles for select to authenticated
  using (id = (select auth.uid()) or (select public.is_staff()));
create policy "profils : soi-même ou Super Admin" on public.profiles for update to authenticated
  using (id = (select auth.uid()) or (select public.is_super_admin()))
  with check (id = (select auth.uid()) or (select public.is_super_admin()));

create policy "journal : lecture équipe" on public.activity_log for select to authenticated
  using ((select public.is_staff()));
create policy "journal : ajout en son nom" on public.activity_log for insert to authenticated
  with check ((select public.is_staff()) and actor_id = (select auth.uid()));

-- Contenu géré par toute l'équipe : Super Admin, Admin et Éditeur
create policy "médias : lecture publique" on public.media for select to anon, authenticated using (true);
create policy "médias : équipe" on public.media for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

create policy "catégories : lecture publique" on public.categories for select to anon, authenticated using (true);
create policy "catégories : équipe" on public.categories for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

create policy "tags : lecture publique" on public.tags for select to anon, authenticated using (true);
create policy "tags : équipe" on public.tags for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

create policy "articles : publiés visibles" on public.articles for select to anon, authenticated using (status = 'published');
create policy "articles : équipe" on public.articles for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

create policy "tags d'article : publiés visibles" on public.article_tags for select to anon, authenticated
  using (exists (select 1 from public.articles a where a.id = article_id and a.status = 'published'));
create policy "tags d'article : équipe" on public.article_tags for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

create policy "campagnes : publiées visibles" on public.campaigns for select to anon, authenticated using (status = 'published');
create policy "campagnes : équipe" on public.campaigns for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

-- Commentaires : le visiteur envoie sur un article ouvert et lit ceux approuvés.
-- Pas de lecture publique pour authenticated, qui a accès à toutes les colonnes :
-- seule l'équipe y lit, sinon un compte non validé pourrait voir les emails.
create policy "commentaires : approuvés visibles" on public.comments for select to anon
  using (status = 'approved' and exists (select 1 from public.articles a where a.id = article_id and a.status = 'published'));
create policy "commentaires : envoi visiteur" on public.comments for insert to anon
  with check (exists (select 1 from public.articles a where a.id = article_id and a.status = 'published' and a.allow_comments));
create policy "commentaires : équipe" on public.comments for all to authenticated
  using ((select public.is_staff())) with check ((select public.is_staff()));

-- Contenu géré par Super Admin et Admin (la page Réglages)
create policy "services : lecture publique" on public.services for select to anon, authenticated using (true);
create policy "services : gestion" on public.services for all to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));

create policy "clients : lecture publique" on public.clients for select to anon, authenticated using (true);
create policy "clients : gestion" on public.clients for all to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));

create policy "offres : publiées visibles" on public.jobs for select to anon, authenticated using (status = 'published');
create policy "offres : gestion" on public.jobs for all to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));

create policy "blocs : publics visibles" on public.site_content for select to anon, authenticated using (is_public);
create policy "blocs : gestion" on public.site_content for all to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));

-- Demandes : tout le monde peut envoyer, seuls Super Admin et Admin peuvent lire
create policy "messages : envoi" on public.contact_messages for insert to anon, authenticated with check (true);
create policy "messages : lecture" on public.contact_messages for select to authenticated using ((select public.is_manager()));
create policy "messages : suivi" on public.contact_messages for update to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));
create policy "messages : suppression" on public.contact_messages for delete to authenticated using ((select public.is_manager()));

create policy "candidatures : envoi" on public.job_applications for insert to anon, authenticated
  with check (job_id is null or exists (select 1 from public.jobs j where j.id = job_id and j.status = 'published'));
create policy "candidatures : lecture" on public.job_applications for select to authenticated using ((select public.is_manager()));
create policy "candidatures : suivi" on public.job_applications for update to authenticated
  using ((select public.is_manager())) with check ((select public.is_manager()));
create policy "candidatures : suppression" on public.job_applications for delete to authenticated using ((select public.is_manager()));

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 10485760, array['image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/svg+xml'])
on conflict (id) do nothing;

create policy "stockage media : équipe" on storage.objects for all to authenticated
  using (bucket_id = 'media' and (select public.is_staff()))
  with check (bucket_id = 'media' and (select public.is_staff()));

commit;
