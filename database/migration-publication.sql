-- Publication automatique depuis l'admin : chaque enregistrement est mis en ligne tout de suite.
-- Un Éditeur peut donc écrire les blocs articles, campaigns et media ; les autres restent réservés à Super Admin et Admin.
-- À exécuter une fois dans Supabase > SQL Editor. Le relancer ne change rien.

begin;

drop policy if exists "blocs : gestion" on public.site_content;
create policy "blocs : gestion" on public.site_content for all to authenticated
  using ((select public.is_manager()) or ((select public.is_staff()) and key in ('articles', 'campaigns', 'media')))
  with check ((select public.is_manager()) or ((select public.is_staff()) and key in ('articles', 'campaigns', 'media')));

commit;
