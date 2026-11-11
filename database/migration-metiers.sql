-- Les 6 premières pages métiers (feuille de route, section 5), en BROUILLON : à relire dans l'admin (Réglages > Pages métiers), puis passer en « Publiée ».
-- À exécuter une fois dans Supabase > SQL Editor, après la mise en ligne du site qui contient metier.html.
-- Sans risque : si les pages métiers existent déjà, rien n'est remplacé.
begin;

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
    "d": "Nous commençons par un audit de vos pages et de celles de vos concurrents. Nous définissons ensuite une ligne éditoriale, un calendrier de publication et le ton de votre marque.\n\nChaque mois, notre équipe crée vos visuels, vos vidéos courtes et vos textes, les publie aux bons moments et anime votre communauté : réponses aux commentaires et aux messages, gestion des avis, relais de vos actualités. Vous validez les contenus avant publication.\n\nÀ la fin du mois, vous recevez un rapport clair : ce qui a été publié, la portée obtenue, les messages reçus et nos recommandations pour le mois suivant."
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
   "kramel-croissance-community-management"
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
    "d": "Spots publicitaires pour la télévision et les réseaux sociaux, films institutionnels, vidéos de lancement de produit, interviews, couverture d''événements, reels et contenus courts, motion design et habillage graphique.\n\nCôté photo, nous réalisons des packshots de vos produits, des portraits de dirigeants et d''équipes, des reportages en entreprise et des photos d''événements."
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
   "groupe-kik-campagne-publicitaire-360"
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
    "d": "Votre identité visuelle, c''est tout ce que vos clients voient de vous : le logo, les couleurs, les typographies, le style des photos, vos cartes de visite, votre enseigne, vos publications sur les réseaux sociaux.\n\nQuand tout est cohérent, votre marque devient reconnaissable au premier coup d''œil et inspire confiance. C''est ce qui permet à une PME de rivaliser avec des concurrents plus grands."
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
   "krystal-optique-nouvelle-identite"
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
    "d": "Lancements de produit, soirées d''entreprise et cérémonies, inaugurations, conférences et séminaires, activations de marque en points de vente, concerts, festivals et compétitions.\n\nNous prenons en charge la conception, la recherche du lieu, la scénographie, les prestataires (son, lumière, décoration, traiteur), l''accueil des invités, la billetterie si besoin, et la couverture photo et vidéo."
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
    "d": "Conseil sur les emplacements selon votre cible et votre budget, réservation des panneaux, création des visuels adaptés à chaque format, impression et pose, affichage digital sur écrans.\n\nNous pouvons aussi coordonner l''affichage avec vos réseaux sociaux et vos autres supports, pour que votre campagne soit vue partout avec le même message."
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
    "d": "Grâce à nos campagnes, à nos événements et à notre présence sur les réseaux sociaux depuis 2013, nous travaillons avec des créateurs de contenu de différents univers : mode, beauté, humour, musique, sport, cuisine, technologie.\n\nNous pouvons aussi associer influenceurs, événement et contenus vidéo dans une même campagne."
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
 }
]'::jsonb, true)
on conflict (key) do nothing;

select jsonb_array_length(value) as pages_metiers from public.site_content where key = 'metiers';

commit;
