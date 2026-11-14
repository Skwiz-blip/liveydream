-- Temps réel dans l'admin : nouvelles demandes, candidatures, commentaires et comptes créés, sans recharger la page.
-- Ajoute ces quatre tables à la diffusion « supabase_realtime ». Les droits de lecture s'appliquent toujours :
-- seuls les membres de l'équipe connectés reçoivent les nouvelles lignes.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
do $$
declare t text;
begin
  foreach t in array array['contact_messages', 'job_applications', 'comments', 'profiles'] loop
    if not exists (select 1 from pg_publication_tables where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = t) then
      execute format('alter publication supabase_realtime add table public.%I', t);
    end if;
  end loop;
end $$;

select tablename from pg_publication_tables where pubname = 'supabase_realtime' and schemaname = 'public' order by tablename;

