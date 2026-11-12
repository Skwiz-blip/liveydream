-- Page Services : le prix de chaque service affiche « Sur devis », sauf le community management (300€ / mois).
-- Les boutons reprennent « Demander un devis ». Les formules « Offres digitales » ne changent pas.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

update public.site_content s set value = (
  select jsonb_agg(
    case
      when e.x ->> 't' = 'Stratégie & Community Management' then e.x || jsonb_build_object('cta', 'Demander un devis')
      else e.x || jsonb_build_object('priceLabel', '', 'price', 'Sur devis', 'cta', 'Demander un devis')
    end
    order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
), updated_at = now()
where s.key = 'services';

select x ->> 't' as service, trim(coalesce(x ->> 'priceLabel', '') || ' ' || coalesce(x ->> 'price', '')) as prix, x ->> 'cta' as bouton
from public.site_content, jsonb_array_elements(value) x where key = 'services';

commit;
