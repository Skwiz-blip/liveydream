-- Page À propos : « UBA » est remplacé par « GIZ » dans la liste des clients cités.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

update public.site_content
  set value = replace(value::text, 'UNICEF, UBA et Ecobank', 'UNICEF, GIZ et Ecobank')::jsonb, updated_at = now()
  where key = 'about' and strpos(value::text, 'UNICEF, UBA et Ecobank') > 0;

select key, strpos(value::text, 'GIZ') > 0 as giz_present, strpos(value::text, 'UBA') > 0 as uba_restant
  from public.site_content where key = 'about';

commit;
