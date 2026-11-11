-- Nouveaux tarifs : page Services (formules « Offres digitales » et prix du community management) et carte noire de l'accueil.
-- Remplace les 3 formules d'abonnement. Tout reste modifiable ensuite dans l'admin (Réglages > Services, Tarifs, Accueil).
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

-- Formules d'abonnement (contrat de 3 mois minimum, prix mensuels)
update public.site_content set value = '[{"name":"Offre Découverte","price":"125€","per":"par mois · 82 000 FCFA","badge":"","cta":"Choisir Découverte","features":["12 posts par mois","1 heure d’entretien / diagnostic","1 réseau social au choix","4 conceptions de visuels","Rapport d’activité mensuel","1 CM dédié","Une semaine de sponsoring page Facebook offerte","Modération des commentaires, messages et likes","Élaboration et mise en place de la stratégie digitale"]},{"name":"Offre Start-up","price":"200€","per":"par mois · 131 000 FCFA","badge":"","cta":"Choisir Start-up","features":["12 posts par mois","2 heures d’entretien / diagnostic","2 réseaux sociaux au choix","Contenu adapté à chaque réseau social","8 conceptions de visuels","Rapport d’activité mensuel","1 CM dédié","Une semaine de sponsoring offerte","Modération des commentaires, messages et likes","1 shooting photo offert","Mise à disposition d’un planning bimestriel","Élaboration et mise en place d’une stratégie de contenu"]},{"name":"Offre PME","price":"300€","per":"par mois · 195 500 FCFA","badge":"","cta":"Choisir PME","features":["20 posts par mois","2 heures d’entretien / diagnostic","2 réseaux sociaux au choix","Contenu adapté à chaque réseau social","12 conceptions de visuels offertes","4 stories HD offertes","Rapport d’activité mensuel","1 CM dédié","Mise à disposition d’un planning trimestriel","1 shooting photo offert","Élaboration et mise en place d’une stratégie de contenu"]}]'::jsonb, updated_at = now() where key = 'plans';

-- Services : prix du community management, et « Demander un devis » devient « Sur devis » sur les boutons des services
update public.site_content s set value = (
  select jsonb_agg(
    case
      when e.x ->> 't' = 'Stratégie & Community Management' then e.x || jsonb_build_object('price', '300€ / mois', 'cta', 'Sur devis')
      when e.x ->> 'cta' = 'Demander un devis' then e.x || jsonb_build_object('cta', 'Sur devis')
      else e.x
    end order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
), updated_at = now()
where s.key = 'services';

-- Carte noire de l'accueil (renvoie vers les formules)
update public.site_content set value = value || '{"k":"Service phare","t":"Offres digitales","d":"Community management clé en main : stratégie, visuels, publications, modération et rapport mensuel. Contrat de 3 mois minimum.","price":"Dès 125€/mois","cta":"Voir les offres"}'::jsonb, updated_at = now()
where key = 'plan';

select key, value from public.site_content where key in ('plan', 'plans')
union all
select 'services', jsonb_agg(jsonb_build_object('t', x ->> 't', 'price', x ->> 'price', 'cta', x ->> 'cta')) from public.site_content, jsonb_array_elements(value) x where key = 'services';

commit;
