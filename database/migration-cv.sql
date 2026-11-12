-- CV joints aux candidatures (page Carrières) : espace de stockage privé « cv ».
-- Un candidat peut seulement DÉPOSER un fichier (PDF ou Word, 5 Mo maximum) dans le dossier candidatures/.
-- Personne ne peut lire, remplacer ou supprimer ces fichiers, sauf un membre de l'équipe connecté à l'admin.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.
begin;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('cv', 'cv', false, 5242880, array[
  'application/pdf',
  'application/msword',
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
])
on conflict (id) do update
  set public = false, file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "cv : dépôt par les candidats" on storage.objects;
create policy "cv : dépôt par les candidats" on storage.objects for insert to anon, authenticated
  with check (bucket_id = 'cv' and (storage.foldername(name))[1] = 'candidatures');

drop policy if exists "cv : lecture par l'équipe" on storage.objects;
create policy "cv : lecture par l'équipe" on storage.objects for select to authenticated
  using (bucket_id = 'cv' and (select public.is_staff()));

drop policy if exists "cv : suppression par l'équipe" on storage.objects;
create policy "cv : suppression par l'équipe" on storage.objects for delete to authenticated
  using (bucket_id = 'cv' and (select public.is_manager()));

select id, public, file_size_limit, allowed_mime_types from storage.buckets where id = 'cv';

commit;
