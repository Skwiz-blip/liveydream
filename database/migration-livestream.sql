begin;

update public.site_content s set value = coalesce((
  select jsonb_agg(e.x order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
  where e.x ->> 't' <> 'Campagne Publicitaire (Ads)'
), '[]'::jsonb), updated_at = now()
where s.key = 'services'
  and exists (select 1 from jsonb_array_elements(s.value) e where e ->> 't' = 'Campagne Publicitaire (Ads)');

update public.site_content s set value = jsonb_set(s.value, '{needs}', coalesce((
  select jsonb_agg(e.x order by e.ord)
  from jsonb_array_elements(s.value -> 'needs') with ordinality as e(x, ord)
  where e.x #>> '{}' <> 'Campagne Publicitaire (Ads)'
), '[]'::jsonb)), updated_at = now()
where s.key = 'contact'
  and exists (select 1 from jsonb_array_elements_text(s.value -> 'needs') e where e = 'Campagne Publicitaire (Ads)');
 
update public.site_content s set value = (
  select jsonb_agg(x order by o) from (
    select e.x, e.ord::numeric as o
    from jsonb_array_elements(s.value) with ordinality as e(x, ord)
    union all
    select n.x, coalesce((select e2.ord from jsonb_array_elements(s.value) with ordinality as e2(x, ord) where e2.x ->> 't' = 'Production Vidéo & Photo'), 1000) + 0.5
    from (select '{"t":"Livestream & Diffusion Live","cat":"Livestream","need":"Livestream & Diffusion Live","d":"Diffusion en direct sur toutes les plateformes, avec régie technique et habillage graphique professionnel.","long":"Votre événement vu par des milliers de personnes, en temps réel. Conférences, lancements de produits, concerts, cérémonies : nous gérons toute la chaîne technique et éditoriale pour diffuser vos événements en direct sur Facebook, YouTube, Instagram et TikTok.","tags":["Facebook Live","YouTube Live","Multi-caméras"],"items":[["Régie multi-caméras","Jusqu''à 4 angles de prise de vue"],["Diffusion multi-plateformes","Facebook Live, YouTube Live, Instagram Live et TikTok Live en simultané"],["Habillage graphique","Bandeau, overlays et titres à vos couleurs"],["Modération en direct","Animation et modération de l''audience en temps réel"],["Sous-titrage en direct","En option"],["Replay et rapport","Replay disponible sous 24 h et rapport d''audience après l''événement"]],"priceLabel":"","price":"","cta":"Sur devis","imgLabel":"Livestream","img":""}'::jsonb as x) n
  ) t
), updated_at = now()
where s.key = 'services'
  and not exists (select 1 from jsonb_array_elements(s.value) e where e ->> 't' = 'Livestream & Diffusion Live');
 
update public.site_content s set value = jsonb_set(s.value, '{needs}', (
  select jsonb_agg(x order by o) from (
    select e.x, e.ord::numeric as o
    from jsonb_array_elements(s.value -> 'needs') with ordinality as e(x, ord)
    union all
    select to_jsonb('Livestream & Diffusion Live'::text), coalesce((select e2.ord from jsonb_array_elements(s.value -> 'needs') with ordinality as e2(x, ord) where e2.x #>> '{}' = 'Production Vidéo & Photo'), 1000) + 0.5
  ) t
)), updated_at = now()
where s.key = 'contact'
  and not exists (select 1 from jsonb_array_elements_text(s.value -> 'needs') e where e = 'Livestream & Diffusion Live');

select x ->> 't' as service, x ->> 'cta' as bouton from public.site_content, jsonb_array_elements(value) x where key = 'services';
select value -> 'needs' as besoins from public.site_content where key = 'contact';
commit;


git add -A
git commit -m "Campagnes : compteur retiré ; Services : Livestream seul, Ads retiré"
git push
cd admin
git add -A
git commit -m "Campagnes : champs secteur, accroche, LYD Original"
git push
