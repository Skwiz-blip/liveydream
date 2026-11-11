-- Reprend de l'ancien liveydream.com (archive du 8 août 2026) les logos clients et les vrais témoignages, avec leurs auteurs.
-- Les images sont dans le site : images/clients/ et images/temoignages/.
-- À exécuter une fois dans Supabase > SQL Editor, APRÈS la mise en ligne du site qui contient ces images.
-- Attention : remplace entièrement les blocs « Logos clients » et « Témoignages » de l'admin.
begin;

update public.site_content set value = '[
 {
  "name": "Togocom",
  "img": "images/clients/togocom.webp"
 },
 {
  "name": "TotalEnergies",
  "img": "images/clients/totalenergies.webp"
 },
 {
  "name": "Akofa",
  "img": "images/clients/akofa.webp"
 },
 {
  "name": "Hype Lounge Bar",
  "img": "images/clients/hype.webp"
 },
 {
  "name": "Woodin",
  "img": "images/clients/woodin.webp"
 },
 {
  "name": "L''Afriklub Karting",
  "img": "images/clients/afriklub-karting.webp"
 },
 {
  "name": "Canal+",
  "img": "images/clients/canal-plus.webp"
 },
 {
  "name": "Servair Togo",
  "img": "images/clients/servair-togo.webp"
 },
 {
  "name": "Gnadoé Digital Média",
  "img": "images/clients/gnadoe-digital-media.webp"
 },
 {
  "name": "USAID",
  "img": "images/clients/usaid.webp"
 },
 {
  "name": "Banque mondiale",
  "img": "images/clients/banque-mondiale.webp"
 },
 {
  "img": "",
  "name": "Gnadoe Magazine Awards"
 },
 {
  "img": "",
  "name": "Group KIK"
 },
 {
  "img": "",
  "name": "MANTA HUB"
 },
 {
  "img": "",
  "name": "KRYSTAL"
 },
 {
  "img": "",
  "name": "ABISCREAM"
 },
 {
  "img": "",
  "name": "LDM"
 },
 {
  "img": "",
  "name": "KRAMEL"
 }
]'::jsonb, updated_at = now() where key = 'clients';

update public.site_content set value = '[
 {
  "n": "Maïdissa",
  "o": "Gérante du Hype",
  "img": "images/temoignages/maidissa.webp",
  "q": "LIVE Y DREAM nous accompagne depuis déjà trois ans dans la création de nos différents supports de communication. Dès le début de notre collaboration, ils ont su s’imprégner de notre culture d’entreprise pour nous proposer une identité visuelle unique. Leur réactivité est sans aucun doute leur atout majeur. Leur créativité sublime nos produits, tandis que leur pragmatisme permet de respecter efficacement les délais. Une belle agence que je recommande sans hésitation !"
 },
 {
  "n": "Maxime Minasseh",
  "o": "Coordinateur général de la Foire Adjafi",
  "img": "images/temoignages/maxime-minasseh.webp",
  "q": "Les missions confiées à LIVE Y DREAM ont été réussies. Une planification rigoureuse, du sérieux et de la créativité nous ont apporté entière satisfaction. Je les recommande sans aucune hésitation !"
 },
 {
  "n": "Magali Palmira Wora",
  "o": "Directrice générale, Real Black Music (MTV Base Africa, Coke Studio Africa, The Voice Africa 2)",
  "img": "images/temoignages/magali-palmira-wora.webp",
  "q": "LIVE Y DREAM apporte de bonnes réponses en matière de visibilité pour notre entreprise. Nos interlocuteurs font preuve d’une excellente capacité d’écoute, tant sur la nature de nos besoins que sur la mise en œuvre des actions pour y répondre. La réactivité et la créativité font aussi partie des points forts de LIVE Y DREAM."
 },
 {
  "n": "Frédéric Lageat",
  "o": "Responsable de L’Afriklub Karting",
  "img": "images/temoignages/frederic-lageat.webp",
  "q": "LIVE Y DREAM est une agence créative, réactive et sympathique, qui sait placer la satisfaction client au cœur de ses préoccupations. À travers les projets réalisés (PLV, campagne publicitaire, marketing digital, graphisme, impressions publicitaires…), LIVE Y DREAM a su répondre à toutes nos envies, quel que soit le niveau de complexité de notre demande. Longue vie à toute l’équipe !"
 }
]'::jsonb, updated_at = now() where key = 'testimonials';

select key, jsonb_array_length(value) as elements from public.site_content where key in ('clients', 'testimonials');

commit;
