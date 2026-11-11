-- Rapatrie les images des articles sur le site : plus aucune dépendance à l'ancien serveur
-- (dream.loremcommunication.com, 91.234.195.181). Les fichiers sont dans images/blog/ du site, en WebP.
-- À exécuter une fois dans Supabase > SQL Editor, APRÈS la mise en ligne du site qui contient images/blog/.
-- Sans risque : seules les adresses ci-dessous sont remplacées ; une relance ne change plus rien.
begin;

-- 70 images
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/xblack-friday-e-commerce-jpg-pagespeed-ic-rws58k47jh.jpg', 'images/blog/2026/10/xblack-friday-e-commerce-jpg-pagespeed-ic-rws58k47jh.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/xblack-friday-e-commerce-jpg-pagespeed-ic-rws58k47jh.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-06-16-at-13-compressed.jpg', 'images/blog/2026/10/whatsapp-image-2026-06-16-at-13-compressed.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-06-16-at-13-compressed.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-24-at-12-compressed.jpg', 'images/blog/2026/10/whatsapp-image-2026-04-24-at-12-compressed.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-24-at-12-compressed.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-22-1.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-20-33-22-1.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-22-1.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-14-53-pm.jpg', 'images/blog/2026/10/whatsapp-image-2023-02-24-at-3-14-53-pm.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-14-53-pm.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-24-21-pm.jpg', 'images/blog/2026/10/whatsapp-image-2023-02-24-at-3-24-21-pm.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-24-21-pm.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-19-05-pm.jpg', 'images/blog/2026/10/whatsapp-image-2023-02-24-at-3-19-05-pm.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-02-24-at-3-19-05-pm.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-29-at-02-39-15.jpg', 'images/blog/2026/10/whatsapp-image-2026-04-29-at-02-39-15.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-29-at-02-39-15.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-29-at-02-24-27.jpg', 'images/blog/2026/10/whatsapp-image-2026-04-29-at-02-24-27.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-29-at-02-24-27.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-24-at-00-16-03.jpg', 'images/blog/2026/10/whatsapp-image-2026-04-24-at-00-16-03.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2026-04-24-at-00-16-03.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-30-04.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-20-30-04.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-30-04.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-22.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-20-33-22.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-22.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-23.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-20-33-23.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-23.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-24.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-20-33-24.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-20-33-24.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-16-51-55.jpg', 'images/blog/2026/10/whatsapp-image-2023-12-29-at-16-51-55.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/whatsapp-image-2023-12-29-at-16-51-55.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2026-04-24-000043968.png', 'images/blog/2026/10/image-2026-04-24-000043968.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2026-04-24-000043968.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/copilot-20250826-182436.png', 'images/blog/2026/10/copilot-20250826-182436.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/copilot-20250826-182436.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/001012692-896x598-c.jpg', 'images/blog/2026/10/001012692-896x598-c.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/001012692-896x598-c.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/lyd212-scaled.jpg', 'images/blog/2026/10/lyd212-scaled.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/lyd212-scaled.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-2-150x150.png', 'images/blog/2026/10/im-2-150x150.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-2-150x150.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-3-150x150.png', 'images/blog/2026/10/im-3-150x150.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-3-150x150.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-4-150x150.png', 'images/blog/2026/10/im-4-150x150.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-4-150x150.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/fofo-skarfo.jpg', 'images/blog/2026/10/fofo-skarfo.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/fofo-skarfo.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-10.jpg', 'images/blog/2026/10/image-10.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-10.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-11.jpg', 'images/blog/2026/10/image-11.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-11.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-12.jpg', 'images/blog/2026/10/image-12.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-12.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-10.png', 'images/blog/2026/10/image-10-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-10.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-6.jpg', 'images/blog/2026/10/image-6.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-6.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-5.jpg', 'images/blog/2026/10/image-5.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-5.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-8.jpg', 'images/blog/2026/10/image-8.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-8.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-9.jpg', 'images/blog/2026/10/image-9.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-9.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2.jpg', 'images/blog/2026/10/image-2.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-1.jpg', 'images/blog/2026/10/image-1.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-1.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-3.jpg', 'images/blog/2026/10/image-3.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-3.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-1.png', 'images/blog/2026/10/image-1-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-1.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2.png', 'images/blog/2026/10/image-2-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-2.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-3.png', 'images/blog/2026/10/image-3-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-3.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-4.png', 'images/blog/2026/10/image-4.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-4.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-5.png', 'images/blog/2026/10/image-5-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-5.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-6.png', 'images/blog/2026/10/image-6-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-6.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-7.png', 'images/blog/2026/10/image-7.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-7.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-8.png', 'images/blog/2026/10/image-8-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-8.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-9.png', 'images/blog/2026/10/image-9-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image-9.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/black-t.jpg', 'images/blog/2026/10/black-t.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/black-t.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image.png', 'images/blog/2026/10/image.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/image.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-14.jpg', 'images/blog/2026/10/im-14.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-14.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-15.jpg', 'images/blog/2026/10/im-15.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-15.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-16.jpg', 'images/blog/2026/10/im-16.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-16.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-17.jpg', 'images/blog/2026/10/im-17.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-17.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-10.jpg', 'images/blog/2026/10/im-10.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-10.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-11.jpg', 'images/blog/2026/10/im-11.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-11.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-12.jpg', 'images/blog/2026/10/im-12.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-12.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-13.jpg', 'images/blog/2026/10/im-13.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-13.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/kanaa.jpg', 'images/blog/2026/10/kanaa.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/kanaa.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-8.jpg', 'images/blog/2026/10/im-8.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-8.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-1.jpg', 'images/blog/2026/10/im-1.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-1.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-2.jpg', 'images/blog/2026/10/im-2.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-2.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-3.jpg', 'images/blog/2026/10/im-3.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-3.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-4.jpg', 'images/blog/2026/10/im-4.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-4.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-1.png', 'images/blog/2026/10/im-1-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-1.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-5.jpg', 'images/blog/2026/10/im-5.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-5.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-5.png', 'images/blog/2026/10/im-5-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-5.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-7.jpg', 'images/blog/2026/10/im-7.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-7.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-6.png', 'images/blog/2026/10/im-6.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-6.png') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-6.jpg', 'images/blog/2026/10/im-6-jpg.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-6.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-9.jpg', 'images/blog/2026/10/im-9.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im-9.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/mic.jpg', 'images/blog/2026/10/mic.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/mic.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/gyl.jpg', 'images/blog/2026/10/gyl.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/gyl.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im.jpg', 'images/blog/2026/10/im.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im.jpg') > 0;
update public.site_content set value = replace(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im.png', 'images/blog/2026/10/im-png.webp')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://dream.loremcommunication.com/uploads/2026/10/im.png') > 0;

-- Liens écrits vers des pages qui n'existent pas sur le nouveau site
update public.site_content set value = replace(value::text, 'https://liveydream.com/blog/strategie-digitale', 'https://liveydream.com/services.html')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://liveydream.com/blog/strategie-digitale') > 0;
update public.site_content set value = replace(value::text, 'https://liveydream.com/blog/community-management-togo', 'https://liveydream.com/blog/pme-community-manager/')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'https://liveydream.com/blog/community-management-togo') > 0;
update public.site_content set value = replace(value::text, 'http://www.liveydream.com/', 'https://liveydream.com/')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, 'http://www.liveydream.com/') > 0;

-- Brouillon « 9 ans à vos côtés » : images cassées (leur adresse était une page, pas une image)
update public.site_content set value = replace(value::text, '<figure><img src=\"https://liveydream.com/9-ans-a-vos-cotes-live-y-dream-a-votre-service/\" alt=\"\" loading=\"lazy\"></figure>', '')::jsonb, updated_at = now()
  where key = 'articles' and strpos(value::text, '<figure><img src=\"https://liveydream.com/9-ans-a-vos-cotes-live-y-dream-a-votre-service/\" alt=\"\" loading=\"lazy\"></figure>') > 0;

-- Contrôle : doit renvoyer 0
select count(*) as adresses_restantes from public.site_content
  where key = 'articles' and (strpos(value::text, 'loremcommunication.com') > 0 or strpos(value::text, '9-ans-a-vos-cotes-live-y-dream-a-votre-service/\"') > 0);

commit;
