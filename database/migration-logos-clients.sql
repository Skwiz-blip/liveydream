-- « Ils nous font confiance » : uniquement les logos de l'ancien liveydream.com. Les noms sans logo sont retirés.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

update public.site_content s set value = coalesce((
  select jsonb_agg(e.x order by e.ord)
  from jsonb_array_elements(s.value) with ordinality as e(x, ord)
  where coalesce(e.x ->> 'img', '') <> ''
), '[]'::jsonb), updated_at = now()
where s.key = 'clients';

select x ->> 'name' as client, x ->> 'img' as logo from public.site_content, jsonb_array_elements(value) x where key = 'clients';

commit;
