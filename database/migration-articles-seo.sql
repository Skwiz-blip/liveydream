-- Articles : titres pour Google trop longs (relevé de Bing Webmaster Tools) et liens entre articles.
-- 1. Un « Titre pour Google » de 60 caractères maximum, sans remplacer un titre déjà saisi dans l'admin (Articles > Référencement).
-- 2. Les liens entre articles passent à l'adresse propre (blog/<article>/) ; deux liens qui menaient à des brouillons sont redirigés.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

update public.site_content set value = replace(value::text, 'blog.html?id=pme-cm-pro\"', 'blog/pme-cm-pro/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=pme-cm-pro\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment\"', 'blog/creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=contenus-viraux\"', 'blog/contenus-viraux/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=contenus-viraux\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=abonnes-clients-fideles\"', 'blog/abonnes-clients-fideles/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=abonnes-clients-fideles\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=les-7-erreurs-de-communication-que-font-les-entreprises-togolaises\"', 'blog/erreurs-communication-togo/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=les-7-erreurs-de-communication-que-font-les-entreprises-togolaises\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=marketing-digital-afrique\"', 'blog/marketing-digital-afrique/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=marketing-digital-afrique\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=comment-attirer-des-clients-sans-publicite\"', 'blog/comment-attirer-des-clients-sans-publicite/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=comment-attirer-des-clients-sans-publicite\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca\"', 'blog/pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=un-outil-de-communication-anodin-mais-puissant\"', 'blog/un-outil-de-communication-anodin-mais-puissant/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=un-outil-de-communication-anodin-mais-puissant\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=communication-en-temps-de-crise\"', 'blog/communication-en-temps-de-crise/\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=communication-en-temps-de-crise\"') > 0;
update public.site_content set value = replace(value::text, 'blog.html?id=liveydream-the-communication-agency-you-need-in-west-africa\"', 'a-propos.html\"')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'blog.html?id=liveydream-the-communication-agency-you-need-in-west-africa\"') > 0;

with t(id, seo) as (values
  ('erreurs-communication-togo', '7 erreurs de communication des entreprises au Togo'),
  ('guide-agence-lome-2026', 'Choisir son agence de communication à Lomé (guide 2026)'),
  ('pme-community-manager', 'Pourquoi une PME au Togo a besoin d’un community manager'),
  ('pme-cm-pro', 'Community manager pour PME au Togo : pourquoi en avoir un'),
  ('abonnes-clients-fideles', 'Transformer vos abonnés en clients fidèles'),
  ('marketing-digital-afrique', 'Marketing digital en Afrique : opportunité ou illusion ?'),
  ('contenus-viraux', 'Contenus viraux : le secret des grandes marques'),
  ('entreprise-invisible-30-jours', 'Entreprise invisible en ligne ? Le plan en 30 jours'),
  ('creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment', 'Créer une marque forte : les étapes essentielles'),
  ('les-7-erreurs-qui-sabotent-votre-communication-et-comment-les-corriger-rapidement', '7 erreurs qui sabotent votre communication'),
  ('comment-attirer-des-clients-sans-publicite', 'Attirer des clients sans publicité : la bonne stratégie'),
  ('pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca', 'Pourquoi 80 % des entreprises échouent sur les réseaux'),
  ('communication-en-temps-de-crise', 'Communication de crise au Togo : fini l’amateurisme'),
  ('black-friday-boostez-vos-ventes-avec-ces-astuces-incontournables', 'Black Friday : astuces pour booster vos ventes')
)
update public.site_content s set value = (
  select jsonb_agg(case when t.id is not null and coalesce(e.x ->> 'seoT', '') = '' then e.x || jsonb_build_object('seoT', t.seo) else e.x end order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
  left join t on t.id = e.x ->> 'id'
), updated_at = now()
where s.key = 'articles';

select x ->> 'id' as article, x ->> 'seoT' as titre_google from public.site_content, jsonb_array_elements(value) x
where key = 'articles' and coalesce(x ->> 'seoT', '') <> '';

commit;
