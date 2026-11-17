-- Médiathèque en fichiers : espace de stockage public « media » (Supabase Storage).
-- Chaque image importée dans l'admin y devient un fichier ; la base (site_content « media ») ne garde que son adresse,
-- son nom et sa description. Les anciennes images (texte dans la base) y sont transférées par l'admin à la mise en ligne suivante.
-- Tout le monde peut voir les images (site public) ; seuls les membres de l'équipe connectés peuvent en ajouter ou en supprimer.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 10485760, array['image/png', 'image/jpeg', 'image/webp', 'image/gif', 'image/svg+xml'])
on conflict (id) do update
  set public = true, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "stockage media : équipe" on storage.objects;
create policy "stockage media : équipe" on storage.objects for all to authenticated
  using (bucket_id = 'media' and (select public.is_staff()))
  with check (bucket_id = 'media' and (select public.is_staff()));

select id, public, file_size_limit from storage.buckets where id = 'media';
select policyname, cmd from pg_policies where schemaname = 'storage' and tablename = 'objects' and policyname like 'stockage media%';

commit;
