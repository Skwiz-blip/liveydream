-- Deux nouveaux services : « Livestream & Diffusion Live » et « Campagne Publicitaire (Ads) ».
-- Ils s'insèrent juste après « Production Vidéo & Photo », sur la page Services, l'accueil et le pied de page,
-- et s'ajoutent aux choix « Votre besoin » du formulaire de contact (avant « Autre »).
-- Ensuite, tout se modifie dans l'admin : Réglages > Services (textes, photo) et Réglages > Contact (liste des besoins).
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

-- 1. Services
update public.site_content s set value = (
  select jsonb_agg(x order by o) from (
    select e.x, e.ord::numeric as o
    from jsonb_array_elements(s.value) with ordinality as e(x, ord)
    union all
    select n.x, coalesce((select e2.ord from jsonb_array_elements(s.value) with ordinality as e2(x, ord) where e2.x ->> 't' = 'Production Vidéo & Photo'), 1000) + n.i / 10.0
    from jsonb_array_elements('[{"t":"Livestream & Diffusion Live","cat":"Livestream","need":"Livestream & Diffusion Live","d":"Diffusion en direct sur toutes les plateformes, avec régie technique et habillage graphique professionnel.","long":"Votre événement vu par des milliers de personnes, en temps réel. Conférences, lancements de produits, concerts, cérémonies : nous gérons toute la chaîne technique et éditoriale pour diffuser vos événements en direct sur Facebook, YouTube, Instagram et TikTok.","tags":["Facebook Live","YouTube Live","Multi-caméras"],"items":[["Régie multi-caméras","Jusqu''à 4 angles de prise de vue"],["Diffusion multi-plateformes","Facebook Live, YouTube Live, Instagram Live et TikTok Live en simultané"],["Habillage graphique","Bandeau, overlays et titres à vos couleurs"],["Modération en direct","Animation et modération de l''audience en temps réel"],["Sous-titrage en direct","En option"],["Replay et rapport","Replay disponible sous 24 h et rapport d''audience après l''événement"]],"priceLabel":"","price":"","cta":"Sur devis","imgLabel":"Livestream","img":""},{"t":"Campagne Publicitaire (Ads)","cat":"Campagne Ads","need":"Campagne Publicitaire (Ads)","d":"Meta Ads, Google Ads, TikTok Ads : stratégie, création et optimisation pour maximiser votre retour sur investissement.","long":"Chaque franc investi doit rapporter. Stratégie, création des visuels, ciblage et optimisation quotidienne : nous pilotons vos campagnes Meta Ads, Google Ads et TikTok Ads pour maximiser votre retour sur investissement en Afrique de l’Ouest.","tags":["Meta Ads","Google Ads","TikTok Ads"],"items":[["Audit et stratégie","Objectifs, audiences et budgets"],["Meta Ads","Facebook et Instagram : trafic, contacts, notoriété, e-commerce"],["Google Ads","Recherche, Display et YouTube"],["TikTok Ads","Notoriété et génération de contacts"],["Création des publicités","Visuels et vidéos adaptés à chaque format"],["Tests et optimisation","Tests A/B des formats et des audiences, suivi quotidien"],["Rapport mensuel","CPC, CPM, coût par contact et ROAS détaillés"]],"priceLabel":"","price":"","cta":"Sur devis","imgLabel":"Campagne Ads","img":""}]'::jsonb) with ordinality as n(x, i)
  ) t
), updated_at = now()
where s.key = 'services'
  and not exists (select 1 from jsonb_array_elements(s.value) e where e ->> 't' in ('Livestream & Diffusion Live', 'Campagne Publicitaire (Ads)'));

-- 2. Choix « Votre besoin » du formulaire de contact
update public.site_content s set value = jsonb_set(s.value, '{needs}', (
  select jsonb_agg(x order by o) from (
    select e.x, e.ord::numeric as o
    from jsonb_array_elements(s.value -> 'needs') with ordinality as e(x, ord)
    union all
    select n.x, coalesce((select e2.ord from jsonb_array_elements(s.value -> 'needs') with ordinality as e2(x, ord) where e2.x #>> '{}' = 'Production Vidéo & Photo'), 1000) + n.i / 10.0
    from jsonb_array_elements('["Livestream & Diffusion Live","Campagne Publicitaire (Ads)"]'::jsonb) with ordinality as n(x, i)
  ) t
)), updated_at = now()
where s.key = 'contact'
  and not exists (select 1 from jsonb_array_elements_text(s.value -> 'needs') e where e in ('Livestream & Diffusion Live', 'Campagne Publicitaire (Ads)'));

select x ->> 't' as service, x ->> 'cta' as bouton from public.site_content, jsonb_array_elements(value) x where key = 'services';
select value -> 'needs' as besoins from public.site_content where key = 'contact';

commit;
