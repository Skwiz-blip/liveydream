-- Les 12 pages métiers de la feuille de route SEO (sections 4 et 5), en BROUILLON :
-- à relire dans l'admin (Réglages > Pages métiers), puis passer en « Publiée » une par une.
-- Adresses : liveydream.com/<id>/ (ex. /agence-evenementielle-lome/), créées à la mise en ligne suivante du site.
-- Faits cités : uniquement ceux du site (À propos, campagnes publiées, clients). Prix « à partir de » laissés vides.
-- Sans risque : une page qui existe déjà (même id) n'est jamais remplacée ; seules les pages absentes sont ajoutées.
-- Corrige aussi le titre et la description Google de l'accueil (accents, mot-clé « agence de communication à Lomé »).
-- À exécuter dans Supabase > SQL Editor. Le relancer ne change rien.

insert into public.site_content (key, value, is_public)
values ('metiers', '[
 {
  "id": "community-manager-lome",
  "status": "brouillon",
  "svc": "Stratégie & Community Management",
  "k": "Community management",
  "h1": "Community manager à Lomé",
  "seoT": "Community manager à Lomé | Live Y Dream",
  "seoD": "Gestion de vos réseaux sociaux à Lomé : stratégie, contenus, modération et rapport mensuel. Demandez votre devis gratuit à Live Y Dream.",
  "intro": "Vous publiez quand vous avez le temps, les messages restent sans réponse et vos pages ne rapportent pas de clients. Nos community managers à Lomé prennent en main vos réseaux sociaux pour en faire un vrai canal de vente.",
  "sections": [
   {
    "t": "Pourquoi confier vos réseaux sociaux à un community manager ?",
    "d": "Au Togo, la plupart de vos clients découvrent votre entreprise sur Facebook, Instagram, TikTok ou WhatsApp avant de vous appeler. Une page abandonnée ou des publications au hasard donnent l''image d''une entreprise peu sérieuse, même si votre produit est excellent.\n\nUn community manager publie avec régularité, répond vite aux questions et transforme les abonnés en clients. C''est un métier à part entière : il demande du temps, une ligne éditoriale claire et des visuels de qualité, ce qu''un dirigeant de PME a rarement le temps de faire lui-même."
   },
   {
    "t": "Ce que fait notre équipe pour vous",
    "d": "Nous commençons par un audit de vos pages et de celles de vos concurrents. Nous définissons ensuite une ligne éditoriale, un calendrier de publication et le ton de votre marque.\n\nChaque mois, notre équipe crée vos visuels, vos vidéos courtes et vos textes, les publie aux bons moments et anime votre communauté : réponses aux commentaires et aux messages, gestion des avis, relais de vos actualités. Vous validez les contenus avant publication.\n\nÀ la fin du mois, vous recevez un rapport clair : ce qui a été publié, la portée obtenue, les messages reçus et nos recommandations pour le mois suivant.\n\nGestion de page Facebook d''entreprise au Togo, animation des réseaux sociaux à Lomé, création de contenus et campagnes sponsorisées : vous avez un seul interlocuteur pour toute votre présence en ligne."
   },
   {
    "t": "Les réseaux que nous gérons",
    "d": "Facebook et Instagram restent les plus utilisés par les entreprises togolaises. TikTok permet de toucher un public jeune avec des vidéos courtes, et LinkedIn est indispensable pour les entreprises qui vendent à d''autres entreprises ou aux institutions.\n\nNous vous conseillons les réseaux qui correspondent vraiment à vos clients, plutôt que d''être partout à moitié. Nous pouvons aussi gérer vos campagnes sponsorisées sur Facebook et Instagram, pour toucher des personnes précises à Lomé ou dans tout le Togo."
   },
   {
    "t": "Une équipe sur place, à Lomé",
    "d": "Live Y Dream accompagne les marques depuis 2013 depuis Hédzranawoé, à Lomé. Nos community managers connaissent le public togolais, ses codes et ses habitudes. Nous travaillons avec notre propre studio photo et vidéo, ce qui permet de produire vos contenus sans intermédiaire."
   }
  ],
  "items": [],
  "method": [
   [
    "Audit de vos réseaux",
    "Analyse de vos pages, de vos concurrents et de votre public."
   ],
   [
    "Stratégie et calendrier",
    "Ligne éditoriale, thèmes du mois et rythme de publication."
   ],
   [
    "Création et publication",
    "Visuels, vidéos courtes et textes, validés par vous puis publiés."
   ],
   [
    "Animation et rapport",
    "Réponses aux messages, rapport mensuel et ajustements."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "woodin-togo-domination-digitale",
   "gnadoe-media"
  ],
  "arts": [
   "pme-community-manager",
   "abonnes-clients-fideles",
   "pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca"
  ],
  "faq": [
   {
    "q": "Combien coûte un community manager au Togo ?",
    "a": "Le prix dépend du nombre de réseaux gérés, du nombre de publications par mois et de la production de photos ou de vidéos. Le tarif de départ est indiqué sur cette page ; nous vous envoyons un devis précis après un premier échange gratuit."
   },
   {
    "q": "Est-ce que je valide les publications avant leur mise en ligne ?",
    "a": "Oui. Nous vous présentons les contenus à l''avance, vous demandez des modifications si besoin, et nous publions seulement ce que vous avez validé."
   },
   {
    "q": "Qui répond aux messages et aux commentaires ?",
    "a": "Notre équipe répond aux questions courantes à partir des informations que vous nous donnez. Les demandes de devis et les questions sensibles vous sont transmises rapidement."
   },
   {
    "q": "Faut-il payer en plus la publicité sur Facebook et Instagram ?",
    "a": "Le budget des publicités sponsorisées est payé directement aux réseaux sociaux et s''ajoute à notre accompagnement. Nous vous conseillons un montant adapté à vos objectifs et nous gérons les campagnes pour vous."
   },
   {
    "q": "Au bout de combien de temps voit-on des résultats ?",
    "a": "Les premiers effets (pages plus actives, plus de messages) se voient souvent dès les premières semaines. Une communauté qui achète se construit sur plusieurs mois de publications régulières : c''est pourquoi nous suivons les résultats chaque mois avec vous."
   }
  ],
  "img": ""
 },
 {
  "id": "production-video-lome",
  "status": "brouillon",
  "svc": "Production Vidéo & Photo",
  "k": "Production vidéo et photo",
  "h1": "Production vidéo à Lomé",
  "seoT": "Production vidéo et spot publicitaire à Lomé | Live Y Dream",
  "seoD": "Spots publicitaires, films institutionnels, reels et shootings photo à Lomé, avec notre propre studio. Demandez votre devis gratuit.",
  "intro": "Une vidéo mal filmée ou mal montée fait fuir vos clients en quelques secondes. Notre équipe de production à Lomé réalise vos spots, vos films d''entreprise et vos contenus pour les réseaux sociaux, de l''idée à la diffusion.",
  "sections": [
   {
    "t": "Des vidéos pensées pour faire vendre",
    "d": "Une bonne vidéo commence par une idée claire : à qui parle-t-on, que doit-on retenir, que doit faire le spectateur ensuite ? Avant de filmer, nous écrivons avec vous le message, le scénario et le plan de tournage.\n\nNous adaptons ensuite le format à l''usage : spot pour la télévision, vidéo verticale pour TikTok et Instagram, film plus long pour présenter votre entreprise à des partenaires ou à des institutions."
   },
   {
    "t": "Ce que nous produisons",
    "d": "Spots publicitaires pour la télévision et les réseaux sociaux, films institutionnels, vidéos de lancement de produit, interviews, couverture d''événements, reels et contenus courts, motion design et habillage graphique.\n\nCôté photo, nous réalisons des packshots de vos produits, des portraits de dirigeants et d''équipes, des reportages en entreprise et des photos d''événements.\n\nSpot publicitaire au Togo pour la télévision ou les réseaux sociaux, film institutionnel pour présenter votre structure à vos partenaires, reportage : chaque format a ses règles. Nous intervenons aussi comme photographe événementiel à Lomé, pour garder des images fortes de vos lancements, conférences et soirées."
   },
   {
    "t": "Un studio et une équipe à Lomé",
    "d": "Nous disposons de notre propre studio à Lomé et d''une équipe qui maîtrise toute la chaîne : direction artistique, tournage, éclairage, son, montage, étalonnage et motion design. Nous tournons aussi en extérieur et dans vos locaux, partout au Togo.\n\nTravailler avec une agence de communication plutôt qu''avec un simple vidéaste a un avantage : la vidéo s''inscrit dans votre stratégie, et nous pouvons la diffuser et la promouvoir sur vos réseaux sociaux."
   }
  ],
  "items": [],
  "method": [
   [
    "Brief et idée",
    "Objectif, public, message et budget de la vidéo."
   ],
   [
    "Scénario et préparation",
    "Script, plan de tournage, lieux, figurants et matériel."
   ],
   [
    "Tournage",
    "En studio, en extérieur ou dans vos locaux."
   ],
   [
    "Montage et livraison",
    "Montage, son, couleurs, sous-titres, formats pour chaque réseau."
   ]
  ],
  "delay": "Le délai dépend du projet (scénario, nombre de jours de tournage, animations) : il est fixé dans le devis avant de commencer.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "daba",
   "ecobank"
  ],
  "arts": [
   "contenus-viraux"
  ],
  "faq": [
   {
    "q": "Combien coûte un spot publicitaire au Togo ?",
    "a": "Le prix dépend de la durée, du nombre de jours de tournage, des lieux, des acteurs et des animations. Après un premier échange gratuit, nous vous proposons un devis détaillé, et si besoin plusieurs options selon votre budget."
   },
   {
    "q": "Pouvez-vous écrire le scénario ?",
    "a": "Oui. Nous pouvons partir de votre idée ou vous proposer des concepts, puis écrire le script et le plan de tournage que vous validez avant le tournage."
   },
   {
    "q": "Tournez-vous en dehors de Lomé ?",
    "a": "Oui, nous tournons partout au Togo. Les frais de déplacement éventuels sont indiqués dans le devis."
   },
   {
    "q": "Dans quels formats livrez-vous les vidéos ?",
    "a": "Nous livrons chaque vidéo dans les formats dont vous avez besoin : horizontal pour la télévision et YouTube, vertical pour TikTok, Instagram et WhatsApp, avec ou sans sous-titres."
   },
   {
    "q": "Puis-je demander des modifications après le montage ?",
    "a": "Oui. Nous vous présentons une première version, puis nous intégrons vos retours. Le nombre de séries de modifications comprises est précisé dans le devis."
   }
  ],
  "img": ""
 },
 {
  "id": "graphisme-identite-visuelle-lome",
  "status": "brouillon",
  "svc": "Conception Graphique & Identité",
  "k": "Graphisme et identité visuelle",
  "h1": "Création de logo et identité visuelle à Lomé",
  "seoT": "Création de logo et identité visuelle à Lomé | LYD",
  "seoD": "Logo, charte graphique, supports imprimés et packaging : une identité visuelle qui inspire confiance. Demandez votre devis gratuit à Lomé.",
  "intro": "Un logo amateur ou des supports qui ne se ressemblent pas donnent une image fragile à votre entreprise. Nos graphistes à Lomé créent une identité visuelle cohérente, reconnaissable et adaptée à votre marché.",
  "sections": [
   {
    "t": "Plus qu''un logo : une identité complète",
    "d": "Votre identité visuelle, c''est tout ce que vos clients voient de vous : le logo, les couleurs, les typographies, le style des photos, vos cartes de visite, votre enseigne, vos publications sur les réseaux sociaux.\n\nQuand tout est cohérent, votre marque devient reconnaissable au premier coup d''œil et inspire confiance. C''est ce qui permet à une PME de rivaliser avec des concurrents plus grands.\n\nQue vous lanciez votre entreprise ou que votre image ait besoin d''un nouveau souffle, une identité visuelle au Togo doit fonctionner partout : sur un téléphone, sur une enseigne en plein soleil et sur un document officiel. C''est le travail d''un graphiste à Lomé qui connaît votre marché."
   },
   {
    "t": "Ce que nous créons",
    "d": "Création ou modernisation de logo, avec ses déclinaisons. Charte graphique complète : couleurs, typographies, règles d''utilisation. Supports imprimés : cartes de visite, flyers, brochures, catalogues, kakémonos. Packaging et étiquettes. Habillage digital : bannières, modèles de publications pour les réseaux sociaux, signatures d''email.\n\nVous recevez tous les fichiers sources, prêts pour l''imprimeur et pour le web."
   },
   {
    "t": "Une méthode qui part de votre marché",
    "d": "Avant de dessiner, nous étudions votre activité, vos clients et vos concurrents. Nous vous présentons ensuite plusieurs pistes créatives, puis nous affinons celle que vous choisissez jusqu''au résultat final.\n\nNotre équipe travaille depuis 2013 pour des marques togolaises et internationales : nous savons ce qui fonctionne sur le marché local, en boutique comme sur les réseaux sociaux."
   }
  ],
  "items": [],
  "method": [
   [
    "Brief",
    "Votre activité, vos clients, vos goûts et vos concurrents."
   ],
   [
    "Pistes créatives",
    "Plusieurs propositions présentées et expliquées."
   ],
   [
    "Affinage",
    "Ajustements sur la piste retenue, jusqu''à validation."
   ],
   [
    "Livraison",
    "Fichiers sources, déclinaisons et charte graphique."
   ]
  ],
  "delay": "Le délai dépend de l''étendue du projet (logo seul ou identité complète) et figure dans le devis.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "ids-magazine"
  ],
  "arts": [
   "creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment"
  ],
  "faq": [
   {
    "q": "Quel est le prix d''un logo ou d''une identité visuelle à Lomé ?",
    "a": "Un logo seul et une identité complète (logo, charte, supports) n''ont pas le même prix. Après un échange gratuit sur votre besoin, nous vous envoyons un devis détaillé."
   },
   {
    "q": "Combien de propositions vais-je recevoir ?",
    "a": "Nous présentons plusieurs pistes créatives au départ. Le nombre de propositions et de séries de retouches est indiqué dans le devis."
   },
   {
    "q": "Est-ce que je reçois les fichiers sources ?",
    "a": "Oui. Vous recevez les fichiers sources et les formats prêts à l''emploi pour l''impression, le web et les réseaux sociaux."
   },
   {
    "q": "Pouvez-vous moderniser mon logo actuel sans tout changer ?",
    "a": "Oui. Si votre logo est déjà connu de vos clients, nous pouvons le moderniser en gardant ce qui fait sa reconnaissance."
   },
   {
    "q": "Vous occupez-vous aussi de l''impression ?",
    "a": "Nous préparons les fichiers pour l''imprimeur et pouvons vous accompagner auprès de nos partenaires d''impression à Lomé."
   }
  ],
  "img": ""
 },
 {
  "id": "agence-evenementielle-lome",
  "status": "brouillon",
  "svc": "Organisation Événementielle",
  "k": "Événementiel",
  "h1": "Agence événementielle à Lomé",
  "seoT": "Agence événementielle à Lomé | Live Y Dream",
  "seoD": "Lancements de produit, soirées d''entreprise, concerts et compétitions : conception, organisation et communication à Lomé. Devis gratuit.",
  "intro": "Un événement mal préparé coûte cher et laisse une mauvaise image. Notre agence événementielle à Lomé conçoit, organise et fait connaître vos événements, de l''idée jusqu''au jour J.",
  "sections": [
   {
    "t": "Des événements conçus pour marquer les esprits",
    "d": "Un événement réussi, c''est une expérience dont vos invités parlent encore le lendemain et qui renforce votre marque. Cela demande une idée forte, une organisation sans faille et une communication avant, pendant et après.\n\nLive Y Dream crée et produit ses propres événements depuis plusieurs années, comme la compétition de danse Battle Arena. Nous mettons cette expérience au service de votre entreprise."
   },
   {
    "t": "Les événements que nous organisons",
    "d": "Lancements de produit, soirées d''entreprise et cérémonies, inaugurations, conférences et séminaires, activations de marque en points de vente, concerts, festivals et compétitions.\n\nNous prenons en charge la conception, la recherche du lieu, la scénographie, les prestataires (son, lumière, décoration, traiteur), l''accueil des invités, la billetterie si besoin, et la couverture photo et vidéo.\n\nOrganisation d''événement à Lomé pour une entreprise, une marque ou une institution : lancement de produit, soirée d''entreprise, conférence ou cérémonie, nous adaptons l''expérience à vos invités et à votre budget."
   },
   {
    "t": "La communication autour de l''événement",
    "d": "Un événement vit aussi en ligne. Nous préparons la campagne d''annonce, les invitations, les visuels et les vidéos, puis nous couvrons l''événement en direct sur vos réseaux sociaux. Après l''événement, vous recevez photos et vidéos pour prolonger son effet.\n\nC''est l''avantage de travailler avec une agence de communication complète : un seul interlocuteur pour l''organisation et la visibilité."
   }
  ],
  "items": [],
  "method": [
   [
    "Concept",
    "Objectifs, public, budget et idée de l''événement."
   ],
   [
    "Organisation",
    "Lieu, prestataires, scénographie, planning et logistique."
   ],
   [
    "Communication",
    "Annonce, invitations, réseaux sociaux et presse."
   ],
   [
    "Jour J et bilan",
    "Coordination sur place, photos et vidéos, bilan."
   ]
  ],
  "delay": "Plus l''événement est préparé tôt, mieux il se déroule : contactez-nous dès que la date est envisagée. Le planning est fixé avec vous dans le devis.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "battle-arena-competition-internationale",
   "lome-by-night-concept-evenementiel"
  ],
  "arts": [
   "guide-agence-lome-2026"
  ],
  "faq": [
   {
    "q": "Combien coûte l''organisation d''un événement à Lomé ?",
    "a": "Tout dépend du nombre d''invités, du lieu, de la durée et des prestations (son, lumière, décoration, traiteur, artistes). Nous établissons un devis détaillé après un premier échange gratuit, et nous pouvons proposer plusieurs options selon votre budget."
   },
   {
    "q": "Combien de temps à l''avance faut-il vous contacter ?",
    "a": "Le plus tôt possible : certains lieux et prestataires se réservent longtemps à l''avance. Pour un petit événement, quelques semaines peuvent suffire ; pour un grand événement, comptez plusieurs mois."
   },
   {
    "q": "Pouvez-vous trouver le lieu de l''événement ?",
    "a": "Oui. Nous vous proposons des lieux adaptés à votre nombre d''invités, à votre image et à votre budget, et nous gérons la réservation."
   },
   {
    "q": "Organisez-vous des lancements de produit ?",
    "a": "Oui, c''est l''un de nos métiers : concept, scénographie, invités, presse, influenceurs et couverture sur les réseaux sociaux pour que le lancement soit vu au-delà de la salle."
   },
   {
    "q": "Gérez-vous aussi la communication de l''événement ?",
    "a": "Oui. Visuels, vidéos, annonce sur les réseaux sociaux, couverture en direct et contenus après l''événement font partie de notre accompagnement."
   }
  ],
  "img": ""
 },
 {
  "id": "affichage-publicitaire-lome",
  "status": "brouillon",
  "svc": "Régie Publicitaire & Affichage",
  "k": "Affichage publicitaire",
  "h1": "Affichage publicitaire à Lomé",
  "seoT": "Affichage publicitaire et panneaux à Lomé | Live Y Dream",
  "seoD": "Panneaux publicitaires, affichage digital et campagnes d''affichage à Lomé : emplacements, création et pose. Demandez votre devis gratuit.",
  "intro": "Une affiche mal placée ou illisible, c''est de l''argent perdu. Nous vous aidons à choisir les bons emplacements à Lomé, à créer un visuel qui se lit en trois secondes et à suivre votre campagne.",
  "sections": [
   {
    "t": "Pourquoi l''affichage fonctionne à Lomé",
    "d": "L''affichage touche tout le monde, tous les jours, sur les grands axes et dans les quartiers où vivent et travaillent vos clients. C''est un excellent moyen de faire connaître une marque, un lancement ou une promotion à grande échelle.\n\nPour être efficace, une campagne d''affichage doit combiner trois choses : les bons emplacements, un message simple et une durée suffisante."
   },
   {
    "t": "Ce que nous prenons en charge",
    "d": "Conseil sur les emplacements selon votre cible et votre budget, réservation des panneaux, création des visuels adaptés à chaque format, impression et pose, affichage digital sur écrans.\n\nNous pouvons aussi coordonner l''affichage avec vos réseaux sociaux et vos autres supports, pour que votre campagne soit vue partout avec le même message.\n\nVous cherchez un panneau publicitaire à Lomé ? Notre régie publicitaire au Togo vous conseille sur la location de panneau la plus adaptée à votre cible : grands axes, carrefours, quartiers d''affaires ou zones commerciales."
   },
   {
    "t": "Un visuel qui se lit en un coup d''œil",
    "d": "Un automobiliste regarde une affiche quelques secondes. Nos graphistes conçoivent des visuels avec un message court, une image forte et votre marque bien visible : tout ce qu''il faut pour être compris et retenu."
   }
  ],
  "items": [],
  "method": [
   [
    "Objectif et cible",
    "Ce que la campagne doit obtenir, et auprès de qui."
   ],
   [
    "Plan d''affichage",
    "Emplacements, formats, durée et budget."
   ],
   [
    "Création",
    "Visuels adaptés à chaque format, validés par vous."
   ],
   [
    "Pose et suivi",
    "Impression, pose, photos de contrôle et bilan."
   ]
  ],
  "delay": "Les disponibilités des panneaux changent vite : le planning de la campagne est confirmé dans le devis.",
  "priceLabel": "",
  "price": "",
  "camps": [],
  "arts": [
   "guide-agence-lome-2026"
  ],
  "faq": [
   {
    "q": "Combien coûte la location d''un panneau publicitaire à Lomé ?",
    "a": "Le prix dépend de l''emplacement, du format du panneau et de la durée de location. Nous vous proposons un plan d''affichage chiffré selon votre budget après un premier échange gratuit."
   },
   {
    "q": "Pour combien de temps peut-on louer un panneau ?",
    "a": "La durée est choisie selon votre objectif. Une campagne trop courte est rarement efficace : nous vous conseillons une durée adaptée à votre message."
   },
   {
    "q": "Vous occupez-vous de la création de l''affiche ?",
    "a": "Oui. Nos graphistes créent des visuels adaptés à chaque format, que vous validez avant l''impression."
   },
   {
    "q": "Comment savoir si mon affiche a bien été posée ?",
    "a": "Nous vous envoyons des photos de contrôle de chaque emplacement après la pose."
   },
   {
    "q": "Peut-on combiner l''affichage avec les réseaux sociaux ?",
    "a": "Oui, et c''est recommandé : le même message vu sur un panneau puis sur son téléphone est beaucoup mieux retenu."
   }
  ],
  "img": ""
 },
 {
  "id": "agence-influence-togo",
  "status": "brouillon",
  "svc": "",
  "k": "Marketing d''influence",
  "h1": "Agence d''influence au Togo",
  "seoT": "Agence d''influence au Togo | Live Y Dream",
  "seoD": "Campagnes avec des influenceurs et créateurs de contenu au Togo : choix des profils, contenus, suivi des résultats. Devis gratuit.",
  "intro": "Vos clients font davantage confiance aux personnes qu''ils suivent qu''aux publicités. Nous trouvons les influenceurs et créateurs de contenu togolais qui parlent vraiment à votre public, et nous pilotons vos campagnes de bout en bout.",
  "sections": [
   {
    "t": "Pourquoi le marketing d''influence fonctionne",
    "d": "Une recommandation d''un créateur de contenu apprécié touche son public de manière plus naturelle qu''une publicité classique. Bien choisi, un influenceur fait découvrir votre marque, donne envie d''essayer votre produit et crée des contenus que vous pouvez réutiliser.\n\nMal choisi, il coûte cher sans rien rapporter. Le choix des profils et le suivi des résultats sont donc essentiels."
   },
   {
    "t": "Ce que nous faisons pour vous",
    "d": "Nous définissons avec vous l''objectif de la campagne et le public visé. Nous sélectionnons ensuite les créateurs de contenu les plus adaptés, en regardant leur audience réelle et leur image, pas seulement leur nombre d''abonnés.\n\nNous gérons la négociation, le brief créatif, la validation des contenus, le calendrier de publication et le bilan de la campagne."
   },
   {
    "t": "Un réseau de créateurs au Togo",
    "d": "Grâce à nos campagnes, à nos événements et à notre présence sur les réseaux sociaux depuis 2013, nous travaillons avec des créateurs de contenu de différents univers : mode, beauté, humour, musique, sport, cuisine, technologie.\n\nNous pouvons aussi associer influenceurs, événement et contenus vidéo dans une même campagne.\n\nLe marketing d''influence à Lomé demande de bien connaître les communautés locales. Nous suivons de près les influenceurs au Togo et les créateurs de contenu à Lomé, leur public et leur manière de parler, pour vous proposer les profils qui correspondent vraiment à votre marque."
   }
  ],
  "items": [
   [
    "Stratégie de campagne",
    "Objectif, public, messages et budget."
   ],
   [
    "Sélection des créateurs",
    "Profils adaptés à votre marque et à votre public."
   ],
   [
    "Pilotage des contenus",
    "Brief, validation et calendrier de publication."
   ],
   [
    "Bilan",
    "Portée, interactions et enseignements de la campagne."
   ]
  ],
  "method": [
   [
    "Objectif",
    "Ce que la campagne doit obtenir et pour qui."
   ],
   [
    "Sélection",
    "Liste de créateurs proposés et validés par vous."
   ],
   [
    "Production",
    "Brief, création des contenus et validation."
   ],
   [
    "Publication et bilan",
    "Suivi des publications et rapport final."
   ]
  ],
  "delay": "Le calendrier de la campagne dépend des disponibilités des créateurs : il est fixé dans le devis.",
  "priceLabel": "",
  "price": "Sur devis selon la campagne",
  "camps": [],
  "arts": [
   "contenus-viraux",
   "marketing-digital-afrique"
  ],
  "faq": [
   {
    "q": "Comment travailler avec des influenceurs au Togo ?",
    "a": "Il faut d''abord fixer un objectif clair, puis choisir des créateurs dont le public correspond à vos clients, leur donner un brief précis et suivre les résultats. Nous gérons toutes ces étapes pour vous."
   },
   {
    "q": "Combien coûte une campagne avec des influenceurs ?",
    "a": "Le budget dépend du nombre de créateurs, de leur audience et du nombre de contenus. Nous vous proposons un devis adapté à votre budget après un premier échange gratuit."
   },
   {
    "q": "Comment choisissez-vous les influenceurs ?",
    "a": "Nous regardons leur public réel, leur taux d''interaction, leur image et la cohérence avec votre marque. Vous validez la sélection avant tout engagement."
   },
   {
    "q": "Est-ce que je valide les contenus avant publication ?",
    "a": "Oui. Les contenus vous sont présentés avant d''être publiés."
   },
   {
    "q": "Comment mesurer les résultats ?",
    "a": "À la fin de la campagne, nous vous remettons un bilan : portée des publications, interactions, et selon l''objectif, les visites, messages ou ventes générés."
   }
  ],
  "img": ""
 },
 {
  "id": "marketing-digital-lome",
  "status": "brouillon",
  "svc": "Campagne Publicitaire (Ads)",
  "k": "Marketing digital",
  "h1": "Agence marketing digital à Lomé",
  "seoT": "Agence marketing digital à Lomé | Live Y Dream",
  "seoD": "Réseaux sociaux, publicité Facebook, Instagram et Google : votre agence marketing digital à Lomé pilote vos campagnes et mesure les résultats.",
  "intro": "Vos clients vous cherchent sur leur téléphone avant de vous appeler. Agence marketing digital à Lomé, Live Y Dream réunit stratégie, contenus, réseaux sociaux et publicité en ligne pour transformer cette attention en demandes de devis et en ventes.",
  "sections": [
   {
    "t": "Le marketing digital, concrètement, pour une entreprise au Togo",
    "d": "Au Togo, la décision d''achat commence presque toujours en ligne : une recherche sur Google, une vidéo vue sur Facebook ou TikTok, une page Instagram consultée, puis un message WhatsApp. Le marketing digital consiste à être présent et convaincant à chacune de ces étapes.\n\nCe n''est pas une question de publier beaucoup. C''est une question de publier ce que vos clients ont besoin de voir, de toucher les bonnes personnes avec la publicité, puis de mesurer ce qui rapporte vraiment pour y mettre davantage de moyens."
   },
   {
    "t": "Ce que nous prenons en charge",
    "d": "Nous construisons d''abord un plan simple : qui sont vos clients, où ils se trouvent en ligne, quel message les convainc et quel budget y consacrer.\n\nNous assurons ensuite la gestion des réseaux sociaux à Lomé et dans tout le Togo, la création des contenus dans notre propre studio photo et vidéo, et les campagnes sponsorisées : publicité Facebook et Instagram au Togo, Google et YouTube. Les demandes reçues arrivent directement sur votre WhatsApp ou votre formulaire de contact.\n\nChaque campagne est suivie avec des indicateurs clairs : personnes touchées, clics, messages reçus, coût par demande. Vous savez ce que chaque franc investi a produit."
   },
   {
    "t": "Des campagnes pilotées par les chiffres",
    "d": "Pour la Délégation de l''Union européenne au Togo, nous avons mené l''achat média de l''« Agir Ensemble Tour » sur Meta (Facebook, Instagram, Reels) et sur Google (YouTube, Display), avec un pilotage des performances en temps réel.\n\nPour AbisCream, marque togolaise de glaces artisanales, nous animons les réseaux sociaux et menons des campagnes de visibilité sur Meta depuis 2021. Pour Gnadoe Media, nous accompagnons la croissance de l''audience et la fidélité des lecteurs depuis 2018."
   },
   {
    "t": "Une agence digitale au Togo, avec une équipe à Lomé",
    "d": "Live Y Dream accompagne les marques depuis 2013. Être une agence digitale au Togo, c''est connaître le public local, ses réseaux préférés, ses horaires et ses codes. Nos équipes de stratégie, de création et de production travaillent ensemble à Lomé : vos campagnes avancent vite, sans intermédiaire."
   }
  ],
  "items": [],
  "method": [
   [
    "Diagnostic",
    "Vos clients, vos concurrents et votre présence en ligne actuelle."
   ],
   [
    "Plan d''action",
    "Objectifs, messages, réseaux, budget publicitaire et indicateurs à suivre."
   ],
   [
    "Lancement",
    "Contenus créés, campagnes mises en ligne, demandes dirigées vers vous."
   ],
   [
    "Mesure et ajustements",
    "Rapport régulier : ce qui rapporte est renforcé, ce qui ne marche pas est arrêté."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "union-europeenne-agir-ensemble",
   "abiscream",
   "gnadoe-media"
  ],
  "arts": [
   "marketing-digital-afrique",
   "entreprise-invisible-30-jours",
   "comment-attirer-des-clients-sans-publicite"
  ],
  "faq": [
   {
    "q": "Quel budget prévoir pour la publicité Facebook et Instagram au Togo ?",
    "a": "Le budget publicitaire est payé directement aux plateformes et s''ajoute à notre accompagnement. Il est possible de commencer avec un petit montant, de mesurer les résultats, puis d''augmenter seulement ce qui rapporte. Nous vous proposons un montant adapté à vos objectifs."
   },
   {
    "q": "Quelle différence entre une agence marketing digital et un community manager ?",
    "a": "Le community manager anime vos réseaux sociaux au quotidien. Le marketing digital va plus loin : stratégie, publicité payante, Google, suivi des demandes et des ventes. Nous pouvons prendre en charge l''un ou l''ensemble."
   },
   {
    "q": "Comment savoir si les campagnes fonctionnent ?",
    "a": "Nous fixons des indicateurs avant le lancement (messages reçus, demandes de devis, coût par demande) et nous vous envoyons un rapport régulier avec nos recommandations."
   },
   {
    "q": "Travaillez-vous avec des entreprises hors de Lomé ?",
    "a": "Oui. Nous ciblons vos clients partout au Togo et dans les pays où vous êtes présent. Nos échanges peuvent se faire à distance, par visioconférence et sur WhatsApp."
   },
   {
    "q": "Faut-il un site internet pour faire du marketing digital ?",
    "a": "Ce n''est pas obligatoire pour commencer : une page bien tenue et WhatsApp suffisent souvent. Un site reste conseillé pour être trouvé sur Google et rassurer les grands comptes ; nous pouvons aussi le créer."
   }
  ],
  "img": ""
 },
 {
  "id": "strategie-communication-branding",
  "status": "brouillon",
  "svc": "",
  "k": "Stratégie et branding",
  "h1": "Stratégie de communication au Togo",
  "seoT": "Stratégie de communication au Togo | Live Y Dream",
  "seoD": "Conseil en communication à Lomé : positionnement, image de marque, plan de communication et campagnes 360° pour votre entreprise au Togo.",
  "intro": "Publier plus ne sert à rien si personne ne comprend ce qui vous rend unique. Nous construisons avec vous une stratégie de communication au Togo : qui vous êtes, à qui vous parlez, ce que vous dites, où et quand.",
  "sections": [
   {
    "t": "Pourquoi une stratégie avant les actions ?",
    "d": "Beaucoup d''entreprises enchaînent les publications, les affiches et les événements sans fil conducteur. Le résultat : un budget dispersé, un message flou et des clients qui ne retiennent pas votre nom.\n\nUne stratégie de communication fixe le cap. Elle définit votre positionnement, vos publics prioritaires, vos messages clés et les canaux qui comptent vraiment pour vous. Chaque action devient alors une pièce d''un même ensemble, et chaque franc dépensé travaille dans la même direction."
   },
   {
    "t": "Conseil en communication à Lomé : ce que nous livrons",
    "d": "Nous commençons par écouter : vos ambitions, vos clients, vos concurrents et l''image que vous renvoyez aujourd''hui. Nous en tirons un diagnostic clair.\n\nNous construisons ensuite votre plateforme de marque (mission, valeurs, promesse, ton), vos messages par public et un plan de communication sur l''année, avec un calendrier et un budget. Si besoin, nous préparons aussi un plan de gestion de crise pour réagir vite et juste quand un sujet sensible apparaît."
   },
   {
    "t": "Branding au Togo : une image de marque qui dure",
    "d": "Votre image de marque d''entreprise se joue dans les détails : un logo cohérent, des couleurs reconnaissables, une manière de parler identique sur vos réseaux, vos affiches et vos documents. Le branding au Togo, c''est rendre votre marque reconnaissable au premier coup d''œil, à Lomé comme dans les régions.\n\nNos graphistes, vidéastes et community managers appliquent la même ligne : la stratégie ne reste pas dans un document, elle se voit partout."
   },
   {
    "t": "Des stratégies déjà déployées",
    "d": "Pour Ecobank, nous avons produit le spot de la Fête des mères, une campagne émotionnelle déployée dans plusieurs pays du groupe, dont le Togo, le Burkina Faso, le Sénégal et la Côte d''Ivoire.\n\nPour GIZ / ProEmploi+, nous avons porté « Homme Allié », une campagne nationale de promotion de la masculinité positive : une caravane de 33 jours à travers le Togo et un documentaire décliné en cinq langues."
   }
  ],
  "items": [],
  "method": [
   [
    "Écoute et diagnostic",
    "Vos objectifs, vos publics, vos concurrents et votre image actuelle."
   ],
   [
    "Positionnement et messages",
    "Plateforme de marque, promesse et messages par public."
   ],
   [
    "Plan de communication",
    "Actions, canaux, calendrier et budget sur l''année."
   ],
   [
    "Déploiement et suivi",
    "Mise en œuvre par nos équipes et points réguliers sur les résultats."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "ecobank",
   "homme-allie"
  ],
  "arts": [
   "creer-une-marque-forte-les-etapes-que-personne-ne-vous-explique-vraiment",
   "erreurs-communication-togo",
   "communication-en-temps-de-crise"
  ],
  "faq": [
   {
    "q": "Quelle différence entre une stratégie et un plan de communication ?",
    "a": "La stratégie fixe le cap : positionnement, publics et messages. Le plan de communication traduit ce cap en actions concrètes, avec un calendrier, des canaux et un budget."
   },
   {
    "q": "Combien de temps faut-il pour construire une stratégie ?",
    "a": "Cela dépend de la taille de votre structure et du nombre d''interlocuteurs à rencontrer. Le délai est précisé dans notre proposition, après un premier échange gratuit."
   },
   {
    "q": "Pouvez-vous faire évoluer notre logo et notre identité existants ?",
    "a": "Oui. Nous partons de ce qui fonctionne déjà chez vous et nous proposons une évolution plutôt qu''une rupture, sauf si un changement complet est vraiment nécessaire."
   },
   {
    "q": "Accompagnez-vous aussi la mise en œuvre ?",
    "a": "Oui. Nos équipes de community management, de production vidéo, de graphisme, d''événementiel et d''affichage peuvent déployer la stratégie, ou travailler avec votre équipe interne."
   },
   {
    "q": "Que faire en cas de crise ou de bad buzz ?",
    "a": "Il faut réagir vite, avec un message clair et assumé. Nous préparons des plans de gestion de crise et nous vous accompagnons quand la situation se présente."
   }
  ],
  "img": ""
 },
 {
  "id": "creation-site-internet-lome",
  "status": "brouillon",
  "svc": "",
  "k": "Création de sites internet",
  "h1": "Création de site internet à Lomé",
  "seoT": "Création de site internet à Lomé | Live Y Dream",
  "seoD": "Site vitrine, site institutionnel ou page de campagne : création de site internet à Lomé, rapide sur mobile et pensé pour Google. Devis gratuit.",
  "intro": "Votre site web est souvent la première impression que vous laissez à un client, un partenaire ou un bailleur. Nous créons à Lomé des sites clairs, rapides sur téléphone et pensés pour être trouvés sur Google.",
  "sections": [
   {
    "t": "Pourquoi un site web au Togo, quand on est déjà sur les réseaux ?",
    "d": "Les réseaux sociaux sont indispensables, mais ils ne vous appartiennent pas : leurs règles changent et vos publications disparaissent vite du fil. Un site web au Togo reste votre vitrine officielle, disponible jour et nuit.\n\nC''est lui que Google montre quand un client cherche votre métier à Lomé. C''est aussi lui que consultent les grandes entreprises, les institutions et les bailleurs avant de vous confier un marché : un site sérieux rassure."
   },
   {
    "t": "Les sites que nous réalisons",
    "d": "Un site vitrine pour présenter votre entreprise, vos services et vos coordonnées, avec un bouton WhatsApp et un formulaire de contact. Un site institutionnel pour une organisation, une ONG ou une institution, avec ses actualités et ses rapports. Une page de campagne ou d''événement, par exemple pour recueillir des inscriptions.\n\nSi vous souhaitez vendre en ligne, nous étudions avec vous la solution la plus adaptée à votre activité et aux moyens de paiement utilisés au Togo."
   },
   {
    "t": "Ce qui est compris",
    "d": "Un design à vos couleurs, créé par nos graphistes. Des textes et des photos de qualité, avec notre studio si vous n''en avez pas. Un site rapide sur téléphone. Les bases du référencement : titres, descriptions, adresse et téléphone identiques à votre fiche Google, inscription du site auprès de Google.\n\nNous vous aidons à réserver votre nom de domaine et à choisir l''hébergement ; ils restent à votre nom. À la livraison, nous vous montrons comment mettre à jour votre site vous-même."
   },
   {
    "t": "Développeurs web à Lomé : l''exemple de Wakabi",
    "d": "Notre équipe a conçu et développé Wakabi, notre propre guide local et plateforme communautaire : adresses, événements et bons plans, avec ses formats éditoriaux. Nos développeurs web à Lomé travaillent avec les équipes de création et de contenu de l''agence, pour que votre site soit à la fois beau, utile et facile à faire vivre."
   }
  ],
  "items": [],
  "method": [
   [
    "Cadrage",
    "Objectifs du site, pages nécessaires, contenus disponibles."
   ],
   [
    "Maquette",
    "Le design de vos pages principales, validé par vous."
   ],
   [
    "Développement et contenus",
    "Site construit, textes et photos intégrés, essais sur téléphone."
   ],
   [
    "Mise en ligne et prise en main",
    "Site publié, inscrit auprès de Google, et vous apprenez à le mettre à jour."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "wakabi"
  ],
  "arts": [
   "entreprise-invisible-30-jours",
   "comment-attirer-des-clients-sans-publicite"
  ],
  "faq": [
   {
    "q": "Combien coûte un site internet à Lomé ?",
    "a": "Le prix dépend du nombre de pages, des fonctions souhaitées et des contenus à produire. Nous vous envoyons un devis précis après un premier échange gratuit."
   },
   {
    "q": "Combien de temps faut-il pour créer un site vitrine ?",
    "a": "Le délai est précisé dans notre proposition. Il dépend surtout de la disponibilité de vos textes, photos et validations."
   },
   {
    "q": "Pourrai-je modifier mon site moi-même ?",
    "a": "Oui. À la livraison, nous vous montrons comment changer les textes, les photos et publier des actualités."
   },
   {
    "q": "Le nom de domaine et l''hébergement sont-ils à mon nom ?",
    "a": "Oui. Ils sont enregistrés à votre nom : votre site vous appartient."
   },
   {
    "q": "Mon site sera-t-il visible sur Google ?",
    "a": "Nous posons les bases techniques et inscrivons le site auprès de Google. Une bonne place dans les résultats se gagne ensuite avec des contenus réguliers et des avis clients ; nous pouvons vous accompagner sur ce point."
   }
  ],
  "img": ""
 },
 {
  "id": "formation-marketing-digital-lome",
  "status": "brouillon",
  "svc": "",
  "k": "Formation (LYDA)",
  "h1": "Formation en marketing digital à Lomé",
  "seoT": "Formation marketing digital à Lomé | Live Y Dream",
  "seoD": "Formations pratiques en marketing digital à Lomé avec LYDA : réseaux sociaux, community management, publicité Facebook et Instagram.",
  "intro": "Vous voulez que votre équipe gère elle-même vos réseaux sociaux, ou devenir community manager ? LYDA, le pôle formation de Live Y Dream, propose à Lomé des formations en marketing digital concrètes, animées par des professionnels qui pratiquent ces métiers chaque jour.",
  "sections": [
   {
    "t": "Des formations tirées du terrain",
    "d": "Nos formateurs sont les membres de l''agence qui gèrent chaque jour les réseaux sociaux, les campagnes publicitaires et les productions de nos clients. Les exemples viennent du marché togolais, pas de manuels étrangers.\n\nChaque formation alterne explications courtes et exercices pratiques. Quand c''est possible, nous travaillons directement sur vos propres pages et vos propres projets : vous repartez avec des résultats, pas seulement avec des notes."
   },
   {
    "t": "Les thèmes que nous enseignons",
    "d": "La formation community manager au Togo : ligne éditoriale, calendrier, animation de communauté, réponses aux messages. La formation réseaux sociaux pour l''entreprise : choisir ses réseaux, publier avec régularité, transformer les abonnés en clients.\n\nNous formons aussi à la publicité Facebook et Instagram, à la création de contenus avec un smartphone (photos et vidéos courtes), à la construction d''une stratégie de communication et à la lecture des statistiques pour savoir ce qui fonctionne."
   },
   {
    "t": "En entreprise ou en session ouverte",
    "d": "En entreprise, nous construisons un programme adapté à votre équipe, à votre secteur et à votre niveau, dans vos locaux ou dans les nôtres à Lomé.\n\nNos sessions ouvertes réunissent des participants de plusieurs structures. Les dates sont annoncées sur nos réseaux sociaux ; vous pouvez aussi nous écrire pour être prévenu de la prochaine session."
   },
   {
    "t": "Pour qui ?",
    "d": "Les dirigeants de PME qui veulent comprendre et piloter leur communication, les chargés de communication et de marketing, les équipes des ONG et des institutions, ainsi que les étudiants et jeunes diplômés qui veulent se lancer dans les métiers du digital."
   }
  ],
  "items": [],
  "method": [
   [
    "Analyse du besoin",
    "Votre niveau, vos objectifs et ceux de votre équipe."
   ],
   [
    "Programme",
    "Thèmes, durée et exercices adaptés, validés avec vous."
   ],
   [
    "Formation pratique",
    "Explications courtes et mise en application immédiate."
   ],
   [
    "Bilan",
    "Un échange de fin de formation pour fixer les prochaines étapes."
   ]
  ],
  "delay": "Les formations en entreprise sont planifiées avec vous après validation du devis ; les dates des sessions ouvertes sont annoncées sur nos réseaux sociaux.",
  "priceLabel": "",
  "price": "",
  "camps": [],
  "arts": [
   "pme-cm-pro",
   "contenus-viraux",
   "pourquoi-80-des-entreprises-echouent-sur-les-reseaux-sociaux-et-comment-eviter-ca"
  ],
  "faq": [
   {
    "q": "Faut-il des connaissances pour suivre une formation ?",
    "a": "Non pour les formations d''initiation. Pour les autres, nous vérifions votre niveau avant de vous proposer le programme adapté."
   },
   {
    "q": "Pouvez-vous former toute mon équipe dans nos locaux ?",
    "a": "Oui. Nous construisons un programme sur mesure et nous venons former votre équipe dans vos locaux, à Lomé ou ailleurs au Togo."
   },
   {
    "q": "Quand ont lieu les prochaines sessions ?",
    "a": "Les dates sont annoncées sur nos réseaux sociaux. Écrivez-nous sur WhatsApp ou par le formulaire pour être prévenu."
   },
   {
    "q": "Combien coûte une formation ?",
    "a": "Le prix dépend du format, de la durée et du nombre de participants. Nous vous envoyons un devis après un premier échange."
   },
   {
    "q": "La formation est-elle vraiment pratique ?",
    "a": "Oui. Chaque notion est appliquée tout de suite, si possible sur vos propres pages et vos propres projets."
   }
  ],
  "img": ""
 },
 {
  "id": "communication-institutions-ong",
  "status": "brouillon",
  "svc": "",
  "k": "Institutions et ONG",
  "h1": "Campagnes de sensibilisation au Togo",
  "seoT": "Campagne de sensibilisation au Togo | Live Y Dream",
  "seoD": "Agence de communication pour ONG et institutions au Togo : campagnes de sensibilisation, caravanes, documentaires et ateliers, jusque dans les régions.",
  "intro": "Faire changer les comportements demande plus qu''une affiche. Agence de communication pour les ONG et les institutions au Togo, Live Y Dream conçoit et déploie des campagnes de sensibilisation qui touchent les populations jusque dans les régions, dans leurs langues.",
  "sections": [
   {
    "t": "La communication pour le développement, un métier à part",
    "d": "Une campagne de sensibilisation au Togo doit parler à des publics très différents : en ville et dans les villages, en français et dans les langues nationales, sur les réseaux sociaux comme sur le terrain. Les messages doivent être simples, justes et respectueux des réalités locales.\n\nLa communication pour le développement demande aussi de la rigueur : respecter les règles de visibilité des bailleurs, faire valider chaque contenu et rendre compte des résultats. C''est notre quotidien depuis nos premiers partenariats institutionnels."
   },
   {
    "t": "Homme Allié : une campagne nationale pour GIZ / ProEmploi+",
    "d": "Pour GIZ / ProEmploi+, nous avons mené une campagne nationale de promotion de la masculinité positive. Une caravane de 33 jours a parcouru le Togo et touché directement plus de 16 000 personnes.\n\nNous avons aussi produit le documentaire « Homme Allié : L''histoire » : 10 minutes, en français, éwé et kabyè, sous-titré en français et en anglais, puis décliné en cinq langues dont quatre langues nationales togolaises (éwé, kabyè, tem/kotokoli et moba)."
   },
   {
    "t": "Ce que nous prenons en charge",
    "d": "La conception des messages et des supports, les caravanes et activations de terrain, les documentaires et films de sensibilisation, les campagnes sur les réseaux sociaux et l''achat média, la couverture photo et vidéo, les relations médias.\n\nNous organisons aussi les ateliers et restitutions de projets. Pour Électriciens sans frontières, nous avons organisé à Lomé l''atelier de restitution finale du projet SISAM2, avec 40 à 50 décideurs, ONG et partenaires : lieu, technique, accueil, protocole, restauration, relations médias et couverture photo."
   },
   {
    "t": "Ils nous ont fait confiance",
    "d": "UNICEF, GIZ, USAID, la Banque mondiale, la Délégation de l''Union européenne au Togo et Électriciens sans frontières font partie des organisations que nous avons accompagnées. Pour l''Union européenne, nous avons mené la campagne en ligne de l''« Agir Ensemble Tour », à Lomé et en régions."
   }
  ],
  "items": [],
  "method": [
   [
    "Comprendre les publics",
    "Qui doit changer quoi, où, et avec quels obstacles."
   ],
   [
    "Concevoir les messages",
    "Messages, langues et supports, validés avec vous et le bailleur."
   ],
   [
    "Déployer",
    "Terrain, médias, réseaux sociaux et événements, partout où sont vos publics."
   ],
   [
    "Mesurer et rendre compte",
    "Indicateurs suivis et rapport final pour vos partenaires."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "homme-allie",
   "union-europeenne-agir-ensemble",
   "electriciens-sans-frontieres"
  ],
  "arts": [],
  "faq": [
   {
    "q": "Respectez-vous les règles de visibilité des bailleurs ?",
    "a": "Oui. Nous intégrons les règles qui nous sont transmises (logos, mentions, validations) et nous faisons valider chaque support avant diffusion."
   },
   {
    "q": "Pouvez-vous produire des contenus en langues nationales ?",
    "a": "Oui. Le documentaire « Homme Allié » a été décliné en éwé, kabyè, tem/kotokoli et moba, en plus du français."
   },
   {
    "q": "Intervenez-vous hors de Lomé ?",
    "a": "Oui. La caravane « Homme Allié » a parcouru le Togo pendant 33 jours, et l''« Agir Ensemble Tour » s''est déroulé à Lomé et en régions."
   },
   {
    "q": "Comment mesurez-vous l''impact d''une campagne ?",
    "a": "Nous définissons les indicateurs avec vous dès le départ (personnes touchées, participation, portée en ligne) et nous vous remettons un rapport."
   },
   {
    "q": "Pouvez-vous organiser un atelier ou une restitution de projet ?",
    "a": "Oui, de bout en bout : lieu, technique, accueil des délégués, protocole, restauration, relations médias et couverture photo."
   }
  ],
  "img": ""
 },
 {
  "id": "marketing-territorial-evenements",
  "status": "brouillon",
  "svc": "",
  "k": "Territoires et tourisme",
  "h1": "Marketing territorial au Togo",
  "seoT": "Marketing territorial au Togo | Live Y Dream",
  "seoD": "Promotion touristique et communication de destination au Togo : festivals, événements, contenus et campagnes pour faire rayonner votre territoire.",
  "intro": "Une ville, une région ou un site touristique se choisit comme une marque. Nous aidons les acteurs du tourisme et des territoires à se faire connaître au Togo et au-delà, avec des contenus, des événements et des campagnes qui donnent envie de venir.",
  "sections": [
   {
    "t": "Promouvoir un territoire, c''est raconter une expérience",
    "d": "Les visiteurs, la diaspora et les investisseurs ne choisissent pas une destination sur une liste de monuments. Ils la choisissent pour une ambiance, une cuisine, des rencontres et des moments qu''ils ont vus en vidéo ou entendus raconter.\n\nLe marketing territorial au Togo consiste à révéler ces expériences, à leur donner un nom et une image, puis à les faire circuler là où se trouvent les publics : réseaux sociaux, médias, événements, influenceurs."
   },
   {
    "t": "Lomé By Night : faire découvrir la capitale autrement",
    "d": "Lomé By Night est un concept créé par Live Y Dream pour explorer les facettes nocturnes de Lomé, autour de la découverte culturelle et gastronomique de la capitale. Deux éditions, plus de 1 000 participants, des places vendues en ligne jusqu''à afficher complet, et une communication qui a beaucoup circulé sur les réseaux sociaux."
   },
   {
    "t": "Wakabi : un guide local conçu par LYD",
    "d": "Avec Wakabi, notre guide local et plateforme communautaire, nous mettons en valeur les adresses, les événements et les bons plans, avec des formats éditoriaux propres (Spot, Bon Plan, Actu, Immersion). C''est notre manière de faire vivre la promotion touristique au Togo au quotidien, avec une communauté qui grandit."
   },
   {
    "t": "La communication d''une destination, de A à Z",
    "d": "Nous construisons l''identité de votre destination ou de votre événement, nous produisons les photos et les vidéos dans notre studio et sur le terrain, et nous menons les campagnes qui ciblent les visiteurs, la diaspora et les médias.\n\nNous concevons et organisons aussi des festivals et des concepts d''événements, comme nous l''avons fait avec Lomé By Night et Battle Arena, et nous travaillons avec des créateurs de contenu pour toucher un public plus large."
   }
  ],
  "items": [],
  "method": [
   [
    "Diagnostic du territoire",
    "Ce qui rend votre destination unique, et pour quels publics."
   ],
   [
    "Récit et identité",
    "Un nom, une image et des messages qui donnent envie de venir."
   ],
   [
    "Événements et contenus",
    "Festivals, expériences, photos et vidéos qui font parler."
   ],
   [
    "Diffusion et mesure",
    "Campagnes, médias, influenceurs et suivi des résultats."
   ]
  ],
  "delay": "Le démarrage se fait en général dans les jours qui suivent la validation du devis : le délai exact est précisé dans votre proposition.",
  "priceLabel": "",
  "price": "",
  "camps": [
   "lome-by-night-concept-evenementiel",
   "wakabi"
  ],
  "arts": [
   "contenus-viraux"
  ],
  "faq": [
   {
    "q": "À qui s’adresse le marketing territorial ?",
    "a": "Aux collectivités, aux acteurs du tourisme (hôtels, sites, guides, offices), aux organisateurs de festivals et à toute structure qui veut faire connaître un lieu ou une région."
   },
   {
    "q": "Pouvez-vous créer un événement de A à Z ?",
    "a": "Oui. Nous avons créé et organisé nos propres concepts, comme Lomé By Night et Battle Arena : idée, organisation, billetterie, communication et couverture."
   },
   {
    "q": "Comment toucher la diaspora et les visiteurs étrangers ?",
    "a": "Avec des contenus pensés pour eux et des campagnes ciblées sur les réseaux sociaux, pays par pays, complétées par les médias et les créateurs de contenu."
   },
   {
    "q": "Travaillez-vous avec des influenceurs ?",
    "a": "Oui. Nous choisissons des créateurs de contenu dont le public correspond à vos visiteurs et nous suivons les résultats de chaque collaboration."
   },
   {
    "q": "Combien coûte une campagne de promotion touristique ?",
    "a": "Cela dépend de la durée, des contenus à produire et des médias choisis. Nous vous envoyons un devis après un premier échange gratuit."
   }
  ],
  "img": ""
 }
]'::jsonb, true)
on conflict (key) do update
  set value = public.site_content.value || coalesce((
    select jsonb_agg(n.page)
    from jsonb_array_elements(excluded.value) n(page)
    where not exists (
      select 1 from jsonb_array_elements(public.site_content.value) e(page) where e.page->>'id' = n.page->>'id'
    )
  ), '[]'::jsonb);

update public.site_content
set value = jsonb_set(value, '{index}', coalesce(value->'index', '{}'::jsonb) || jsonb_build_object(
  'title', 'Agence de communication à Lomé | Live Y Dream',
  'desc', 'Agence de communication et de publicité à Lomé depuis 2013 : marketing digital, influence, vidéo, événementiel et affichage. Demandez votre audit gratuit.'))
where key = 'seo';

select e.page->>'id' as page, e.page->>'status' as etat, e.page->>'h1' as titre
from public.site_content c, jsonb_array_elements(c.value) e(page)
where c.key = 'metiers';
