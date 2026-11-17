-- Remet dans la Médiathèque les images encore utilisées par le site (media:ID) mais retirées de sa liste.
-- Cause : une mise en ligne depuis une page de l'admin ouverte depuis longtemps renvoyait une vieille Médiathèque
-- (corrigé dans admin/js/admin.js le 17/11/2026 : l'admin relit la version en ligne avant chaque envoi).
-- Une image n'est remise que si son fichier est encore dans le stockage « media ».
-- Le tableau final liste chaque image manquante : « remise » ou « à réimporter depuis l'admin ».
-- À exécuter dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

create temp table images_manquantes on commit drop as
select m[1] as id, string_agg(distinct c.key, ', ') as utilisee_dans
from public.site_content c
cross join lateral regexp_matches(c.value::text, 'media:([a-z0-9]+)', 'gi') m
where c.key <> 'media'
  and not coalesce((select value from public.site_content where key = 'media') ? m[1], false)
group by m[1];

create temp table images_retrouvees on commit drop as
select distinct on (i.id) i.id, o.name
from images_manquantes i
join storage.objects o on o.bucket_id = 'media' and o.name like i.id || '-%'
order by i.id, o.created_at desc;

-- Adresse publique du stockage, reprise d'une image déjà dans la Médiathèque
update public.site_content s
set value = s.value || (
  select jsonb_object_agg(r.id, jsonb_build_object('src', b.url || r.name, 'name', r.name, 'alt', ''))
  from images_retrouvees r,
       (select regexp_replace(e.value->>'src', '[^/]+$', '') as url
        from jsonb_each(s.value) e
        where e.value->>'src' like '%/storage/v1/object/public/media/%'
        limit 1) b
)
where s.key = 'media'
  and exists (select 1 from images_retrouvees)
  and exists (select 1 from jsonb_each(s.value) e where e.value->>'src' like '%/storage/v1/object/public/media/%');

select i.id as image, i.utilisee_dans,
       case when exists (select 1 from images_retrouvees r where r.id = i.id)
            then 'remise dans la Médiathèque' else 'fichier introuvable : à réimporter depuis l''admin' end as etat
from images_manquantes i
order by i.utilisee_dans, i.id;

commit;
