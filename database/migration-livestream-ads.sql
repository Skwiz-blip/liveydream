-- Services « Livestream & Diffusion Live » et « Campagne Publicitaire (Ads) », d'après le document
-- « Textes DEV — Livestream & Campagne Ads LYD » : textes, accroche, livrables, ancres #livestream et #campagne-ads.
-- Ils se placent juste après « Production Vidéo & Photo » (page Services, accueil, pied de page),
-- et s'ajoutent aux choix « Votre besoin » du formulaire de contact, au même endroit.
-- Ajoute aussi les descriptions pour Google des autres services, ainsi que le titre et la description Google de la page Services.
-- La photo d'un service déjà en place est gardée. Ce script remplace migration-livestream.sql.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer remet les textes du document, sans doublon.
begin;

-- 1. Services
with cur as (select value as v from public.site_content where key = 'services'),
nw as (select n.x, n.i from jsonb_array_elements('[{"t":"Livestream & Diffusion Live","cat":"Livestream & Diffusion Live","slug":"livestream","need":"Livestream & Diffusion Live","acc":"Votre événement vu par des milliers de personnes, en temps réel.","d":"Diffusion en direct sur toutes les plateformes, avec régie technique et habillage graphique professionnel.","long":"Conférences, lancements de produits, concerts, cérémonies : nous gérons toute la chaîne technique et éditoriale pour diffuser vos événements en direct sur Facebook, YouTube, Instagram et TikTok.","ld":"Diffusion en direct multi-plateformes (Facebook, YouTube, Instagram, TikTok) avec régie technique, habillage graphique et modération d''audience.","tags":["Facebook Live","YouTube Live","Multi-caméras"],"items":[["Régie technique multi-caméras","Jusqu''à 4 angles de prise de vue"],["Diffusion simultanée multi-plateformes","Facebook Live, YouTube Live, Instagram Live et TikTok Live"],["Habillage graphique du stream","Bandeau, overlays et titres"],["Modération de l''audience","En temps réel"],["Sous-titrage en direct","En option"],["Rediffusion et replay","Replay téléchargeable sous 24 h"],["Rapport d''audience","Après l''événement"]],"priceLabel":"","price":"","cta":"Sur devis","imgLabel":"Livestream","img":""},{"t":"Campagne Publicitaire (Ads)","cat":"Campagne Publicitaire (Ads)","slug":"campagne-ads","need":"Campagne Publicitaire (Ads)","acc":"Chaque franc investi doit rapporter. Nous le garantissons.","d":"Meta Ads, Google Ads, TikTok Ads : stratégie, création et optimisation pour maximiser votre ROI.","long":"Stratégie, création des visuels, ciblage et optimisation quotidienne : nous pilotons vos campagnes Meta Ads, Google Ads et TikTok Ads pour maximiser votre retour sur investissement en Afrique de l''Ouest.","ld":"Création et optimisation de campagnes Meta Ads, Google Ads et TikTok Ads pour maximiser le ROI des annonceurs en Afrique de l''Ouest.","tags":["Meta Ads","Google Ads","TikTok Ads"],"items":[["Audit et stratégie publicitaire","Objectifs, audiences, budgets"],["Meta Ads","Facebook et Instagram : trafic, leads, notoriété, e-commerce"],["Google Ads","Search, Display et YouTube"],["TikTok Ads","Awareness et génération de leads"],["Création des visuels","Visuels et vidéos pour les publicités"],["A/B testing","Des formats et des audiences"],["Suivi et optimisation","Suivi quotidien et optimisation des campagnes"],["Rapport mensuel détaillé","CPC, CPM, CPL, ROAS"]],"priceLabel":"","price":"","cta":"Sur devis","imgLabel":"Campagne Ads","img":""}]'::jsonb) with ordinality as n(x, i)),
lds as (select key as t, value as ld from jsonb_each_text('{"Stratégie & Community Management":"Gestion de vos réseaux sociaux : création de contenu, modération et stratégie éditoriale.","Production Vidéo & Photo":"Production audiovisuelle professionnelle pour vos marques et campagnes en Afrique de l''Ouest.","Conception Graphique & Identité":"Identité visuelle, supports print et digital pour les marques africaines.","Organisation Événementielle":"Événements, street marketing et expériences de marque au Togo et en Afrique de l''Ouest.","Régie Publicitaire & Affichage":"Achat et planification média : presse, radio, affichage, digital au Togo."}'::jsonb)),
kept as (
  select case when l.ld is null then e.x else e.x || jsonb_build_object('ld', l.ld) end as x, e.ord::numeric as o
  from cur cross join lateral jsonb_array_elements(cur.v) with ordinality as e(x, ord)
  left join lds l on l.t = e.x ->> 't'
  where e.x ->> 't' not in (select nw.x ->> 't' from nw)
),
pos as (
  select coalesce((select e.ord from cur cross join lateral jsonb_array_elements(cur.v) with ordinality as e(x, ord)
    where e.x ->> 't' = 'Production Vidéo & Photo' limit 1), 1000)::numeric as o
),
added as (
  select nw.x || jsonb_build_object('img', coalesce((select nullif(e.x ->> 'img', '') from cur cross join lateral jsonb_array_elements(cur.v) as e(x)
    where e.x ->> 't' = nw.x ->> 't' limit 1), '')) as x,
    (select o from pos) + nw.i / 10.0 as o
  from nw
)
update public.site_content set value = (select jsonb_agg(t.x order by t.o) from (select x, o from kept union all select x, o from added) t),
  updated_at = now()
where key = 'services';

-- 2. Choix « Votre besoin » du formulaire de contact
with cur as (select coalesce(value -> 'needs', '[]'::jsonb) as v from public.site_content where key = 'contact'),
nw as (select n.x, n.i from jsonb_array_elements('["Livestream & Diffusion Live","Campagne Publicitaire (Ads)"]'::jsonb) with ordinality as n(x, i)),
kept as (
  select e.x, e.ord::numeric as o from cur cross join lateral jsonb_array_elements(cur.v) with ordinality as e(x, ord)
  where e.x not in (select x from nw)
),
pos as (
  select coalesce((select e.ord from cur cross join lateral jsonb_array_elements(cur.v) with ordinality as e(x, ord)
    where e.x #>> '{}' = 'Production Vidéo & Photo' limit 1), 1000)::numeric as o
)
update public.site_content set value = jsonb_set(value, '{needs}', (
  select jsonb_agg(t.x order by t.o) from (select x, o from kept union all select nw.x, (select o from pos) + nw.i / 10.0 from nw) t
)), updated_at = now()
where key = 'contact';

-- 3. Titre et description Google de la page Services
update public.site_content set value = jsonb_set(value, '{services}', coalesce(value -> 'services', '{}'::jsonb) || '{"title":"Nos Services — Live Y Dream Lomé","desc":"Community management, vidéo, graphisme, activation, régie, livestream et campagnes ads : tous nos services de communication à Lomé, Togo."}'::jsonb),
  updated_at = now()
where key = 'seo';

select x ->> 't' as service, x ->> 'slug' as ancre, x ->> 'cta' as bouton from public.site_content, jsonb_array_elements(value) x where key = 'services';
select value -> 'needs' as besoins from public.site_content where key = 'contact';
select value -> 'services' as seo_services from public.site_content where key = 'seo';

commit;
