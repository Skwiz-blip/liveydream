-- Page Services : chaque service affiche seulement un bouton « Sur devis », sans prix au-dessus.
-- Seul le community management garde son prix (300€ / mois). À exécuter une fois dans Supabase > SQL Editor.
begin;

update public.site_content s set value = (
  select jsonb_agg(
    case
      when e.x ->> 't' = 'Stratégie & Community Management' then e.x || jsonb_build_object('cta', 'Sur devis')
      else e.x || jsonb_build_object('priceLabel', '', 'price', '', 'cta', 'Sur devis')
    end
    order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
), updated_at = now()
where s.key = 'services';

select x ->> 't' as service, coalesce(nullif(trim(coalesce(x ->> 'priceLabel', '') || ' ' || coalesce(x ->> 'price', '')), ''), '(aucun prix)') as prix, x ->> 'cta' as bouton
from public.site_content, jsonb_array_elements(value) x where key = 'services';

commit;
