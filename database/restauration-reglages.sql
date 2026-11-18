-- Remet les réglages Général et Accueil effacés le 17/11/2026 à 23 h 09 (UTC).
-- Cause : une page de l'admin ouverte alors que le contenu n'avait pas pu être chargé (connexion lente) affichait des
-- champs vides, et sa mise en ligne automatique les a enregistrés. Corrigé dans admin/js/admin.js le 18/11/2026.
-- Valeurs reprises de la page d'accueil construite le 17/11 à 18 h 48 (identiques à celle en ligne).
-- Seuls les champs encore vides sont remplis : un champ déjà ressaisi dans l'admin est gardé.
-- Puis les images utilisées mais absentes de la Médiathèque (dont la photo d'accueil) y sont remises si leur fichier existe.
-- À exécuter dans Supabase > SQL Editor. Le relancer ne change rien.

with ancien as (
  select '{
    "brand": "LIVE Y DREAM",
    "baseline": "L''agence de communication qui transforme vos ambitions en résultats concrets. Depuis 2013, au service des meilleures marques d''Afrique de l''Ouest.",
    "phone": "+228 70 08 77 77",
    "email": "contact@liveydream.com",
    "whatsapp": "https://wa.me/22870087777",
    "hero": {
      "title": "VOS CLIENTS NE PEUVENT PAS VOUS IGNORER",
      "text": "En Afrique, la visibilité est le vrai pouvoir. Nous transformons votre marque en une force incontournable.",
      "image": "media:mwcj4dr84t5cci"
    },
    "stats": [
      {"b": "", "l": "Ans d''expertise", "n": "10+"},
      {"l": "Marques accompagnées", "n": "200+"},
      {"l": "Pays présents", "n": "4"},
      {"l": "Experts dans l''équipe", "n": "15"}
    ],
    "cta": {
      "title": "PRÊT À DOMINER VOTRE MARCHÉ ?",
      "text": "Vos concurrents investissent dans leur communication. Chaque jour que vous attendez est un jour où ils prennent de l''avance. <strong>L''audit est gratuit. Les résultats sont réels.</strong>"
    }
  }'::jsonb as v
),
vides as (
  select array['""', '"#"', '[]', '{}', '{"text": "", "title": ""}', '{"text": "", "image": "", "title": ""}']::jsonb[] as l
)
update public.site_content s
set value = (s.value - array(select jsonb_object_keys(a.v) from ancien a)) || (
  select jsonb_object_agg(k, case when s.value->k is null or (s.value->k) = any (vd.l) then a.v->k else s.value->k end)
  from ancien a, vides vd, jsonb_object_keys(a.v) k
)
where s.key = 'settings';

-- Images utilisées par le site mais absentes de la Médiathèque : remises si leur fichier est dans le stockage « media »
with lib as (
  select value from public.site_content where key = 'media'
),
manquantes as (
  select m[1] as id, string_agg(distinct c.key, ', ') as utilisee_dans
  from public.site_content c
  cross join lateral regexp_matches(c.value::text, 'media:([a-z0-9]+)', 'gi') m
  where c.key <> 'media'
    and not coalesce((select value from lib) ? m[1], false)
  group by m[1]
),
retrouvees as (
  select distinct on (i.id) i.id, o.name
  from manquantes i
  join storage.objects o on o.bucket_id = 'media' and o.name like i.id || '-%'
  order by i.id, o.created_at desc
),
base as (
  select regexp_replace(e.value->>'src', '[^/]+$', '') as url
  from lib, jsonb_each(lib.value) e
  where e.value->>'src' like '%/storage/v1/object/public/media/%'
  limit 1
),
remises as (
  update public.site_content s
  set value = s.value || (
    select jsonb_object_agg(r.id, jsonb_build_object('src', b.url || r.name, 'name', r.name, 'alt', ''))
    from retrouvees r, base b
  )
  where s.key = 'media'
    and exists (select 1 from retrouvees)
    and exists (select 1 from base)
  returning s.key
)
select i.id as image, i.utilisee_dans,
       case when exists (select 1 from retrouvees r where r.id = i.id) and exists (select 1 from remises)
            then 'remise dans la Médiathèque'
            else 'fichier introuvable : à réimporter depuis l''admin' end as etat
from manquantes i
order by i.utilisee_dans, i.id;

-- Vérification : les réglages remis
select value->>'brand' as nom, value->>'phone' as telephone, value->>'whatsapp' as whatsapp,
       value->'hero'->>'title' as grand_titre, jsonb_array_length(value->'stats') as chiffres
from public.site_content where key = 'settings';
