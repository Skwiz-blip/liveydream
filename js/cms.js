/* Live Y Dream - moteur de données (localStorage) + composants partagés */
(function () {
  var KEY = 'lyd_cms_v1';

  var DEFAULTS = {
    settings: {
      brand: 'LIVE Y DREAM',
      whatsapp: 'https://wa.me/22870087777',
      email: 'contact@liveydream.com',
      phone: '+228 70 08 77 77',
      baseline: "L'agence de communication qui transforme vos ambitions en résultats concrets. Depuis 2013, au service des meilleures marques d'Afrique de l'Ouest.",
      hero: {
        title: 'VOS CLIENTS NE PEUVENT PAS VOUS IGNORER',
        text: "En Afrique, la visibilité est le vrai pouvoir. Nous transformons votre marque en une force incontournable.",
        image: ''
      },
      stats: [
        { n: '10+', l: "Ans d'expertise" },
        { n: '200+', l: 'Marques accompagnées' },
        { n: '4', l: 'Pays présents' },
        { n: '15', l: "Experts dans l'équipe" }
      ],
      cta: {
        title: 'PRÊT À DOMINER VOTRE MARCHÉ ?',
        text: "Vos concurrents investissent dans leur communication. Chaque jour que vous attendez est un jour où ils prennent de l'avance. <strong>L'audit est gratuit. Les résultats sont réels.</strong>"
      }
    },

    contact: {
      address: ['177 Rue HDN, Hédzranawoé', 'Lomé, Togo - non loin de STEA'],
      phones: ['+228 70 08 77 77', '+228 90 37 45 60'],
      emails: ['contact@liveydream.com', 'customercare@liveydream.com'],
      hours: [['Lundi - Vendredi', '8h30 - 18h00'], ['Samedi', '9h00 - 14h00'], ['Dimanche', 'Fermé']],
      socials: [
        ['Facebook', 'https://web.facebook.com/228LiveYDream?_rdc=1&_rdr#'],
        ['LinkedIn', 'https://linkedin.com/company/liveydream'],
        ['Instagram', 'https://www.instagram.com/liveydream'],
        ['TikTok', 'https://tiktok.com/@liveydream']
      ],
      needs: ['Community Management', 'Production Vidéo & Photo', 'Conception Graphique & Identité', 'Organisation Événementielle', 'Régie Publicitaire', 'Abonnement PME', 'Stratégie Digitale Complète', 'Autre'],
      budgets: ['Moins de 100 000 FCFA', '100 000 - 300 000 FCFA', '300 000 - 1 000 000 FCFA', 'Plus de 1 000 000 FCFA', 'À définir ensemble']
    },

    problems: [
      { t: 'Vos concurrents gagnent des clients', d: 'Pendant que vous dormez, vos rivaux moins compétents mais mieux communiqués signent des contrats.' },
      { t: 'Votre budget pub ne rapporte rien', d: "Booster vos réseaux sociaux sans stratégie, c'est jeter de l'argent. Chaque FCFA mal dépensé creuse l'écart." },
      { t: 'Votre expertise reste silencieuse', d: "Vous avez de l'expérience et des résultats, mais personne ne le sait. L'invisibilité tue les meilleures entreprises." },
      { t: "Vous n'avez pas le temps", d: 'Gérer votre communication en plus de votre business est impossible. Une com bâclée fait plus de mal que rien.' }
    ],

    services: [
      { t: 'Stratégie & Community Management', cat: 'Community Management', need: 'Community Management',
        d: "Vos réseaux sociaux transformés en machines à attirer des clients. Contenus, calendriers, interactions, on gère tout.",
        long: "Vos réseaux sociaux transformés en machines à attirer des clients. Chaque publication, chaque interaction, un pas vers la conversion.",
        tags: ['Facebook', 'Instagram', 'TikTok', 'LinkedIn'],
        items: [['Stratégie de contenu mensuelle', 'Calendrier éditorial thématique, ligne rédactionnelle'], ['Création de contenu quotidienne', 'Visuels, vidéos courtes, textes, formats adaptés'], ['Modération & engagement', 'Réponses aux messages et commentaires, animation de communauté'], ['Reporting mensuel', "Résultats clairs et mesurables, recommandations d'optimisation"]],
        priceLabel: 'À partir de', price: '75 000 FCFA/mois', cta: 'Demander un devis', img: '' },
      { t: 'Production Vidéo & Photo', cat: 'Production Vidéo & Photo', need: 'Production Vidéo & Photo',
        d: "Des images qui racontent votre marque. Studio équipé, équipe créative, résultats professionnels.",
        long: "Des images qui arrêtent le scroll et des vidéos qui font vendre. Studio équipé broadcast, équipe créative, direction artistique maîtrisée.",
        tags: ['Publicité', 'Corporate', 'Shooting'],
        items: [['Spots publicitaires TV & réseaux', 'Production complète, du script à la diffusion'], ['Shooting produit & corporate', 'Photos packshot, portraits, reportages'], ['Reels & contenus courts', 'Formats verticaux pensés pour les réseaux sociaux'], ['Motion design', 'Animations, génériques, habillage vidéo']],
        priceLabel: '', price: 'Sur devis selon projet', cta: 'Obtenir un devis', img: '', imgLabel: 'Studio Broadcast' },
      { t: 'Conception Graphique & Identité', cat: 'Conception Graphique', need: 'Conception Graphique & Identité',
        d: "Un logo reconnaissable, une identité qui inspire confiance et fait la différence avec vos concurrents.",
        long: "Un logo qui vous rend reconnaissable au premier coup d'œil, une identité qui inspire confiance et vous différencie de vos concurrents.",
        tags: ['Logo', 'Charte', 'Packaging'],
        items: [['Création de logo', 'Concepts originaux, déclinaisons et fichiers sources'], ['Charte graphique complète', 'Couleurs, typographies, règles d\'usage'], ['Supports imprimés', 'Flyers, brochures, cartes, packaging'], ['Habillage digital', 'Bannières, templates réseaux sociaux, signatures']],
        priceLabel: 'À partir de', price: '50€', cta: 'Demander un devis', img: '', imgLabel: 'Identité Visuelle' },
      { t: 'Organisation Événementielle', cat: 'Activation de marque', need: 'Organisation Événementielle',
        d: "Vos événements transformés en expériences mémorables. De la conception au jour J, on s'occupe de tout.",
        long: "Vos événements transformés en expériences mémorables. De la conception au jour J, vous soyez présent à 100%.",
        tags: ['Lancement', 'Corporate', 'Activation'],
        items: [['Conception événement', 'Concept créatif, scénographie, programme'], ['Coordination Jour J', 'Équipe sur place, logistique, gestion des prestataires'], ['Couverture audiovisuelle', 'Photo, vidéo et live pour prolonger l\'événement'], ['Activation de marque', 'Dispositifs qui font vivre votre marque au public']],
        priceLabel: '', price: 'Sur devis selon envergure', cta: 'Obtenir un devis', img: '', imgLabel: 'Activation de Marque' },
      { t: 'Régie Publicitaire & Affichage', cat: 'Régie Publicitaire', need: 'Régie Publicitaire',
        d: "Panneaux, affichage digital, pub Facebook/Google, chaque FCFA investi compte.",
        long: "Panneaux, affichage digital, pub Facebook/Google : nous gérons vos investissements publicitaires pour maximiser chaque FCFA dépensé.",
        tags: ['Billboards', 'Facebook ads', 'Activation'],
        items: [['Affichage extérieur & billboards', 'Emplacements stratégiques, pose et suivi'], ['Facebook & Instagram Ads', 'Campagnes ciblées, créations et optimisation'], ['Google Ads & SEA', 'Campagnes de recherche et de display'], ['Suivi & optimisation', 'Reporting régulier et ajustements en continu']],
        priceLabel: 'À partir de', price: '100€/mois', cta: 'Demander un devis', img: '', imgLabel: 'Régie Publicitaire' }
    ],

    plan: { k: 'Offre PME', t: 'Abonnement Communication PME', d: 'La solution tout-en-un pour les PME. Visibilité garantie, résultats mesurés, sans se prendre la tête.', price: 'Dès 200€/mois', cta: "Découvrir l'offre" },

    plans: [
      { name: 'Starter', price: '100€', per: 'par mois', badge: '', cta: 'Choisir Starter', features: ['1 réseau social géré', '12 publications/mois', 'Création de visuels', 'Modération basique', 'Rapport mensuel'] },
      { name: 'Pro', price: '250€', per: 'par mois', badge: 'Recommandé', cta: 'Choisir Pro', features: ['3 réseaux sociaux', '20 publications/mois', 'Shooting mensuel inclus', 'Modération 7j/7', 'Stories & Reels', 'Rapport détaillé'] },
      { name: 'Premium', price: '500€', per: 'par mois', badge: '', cta: 'Choisir Premium', features: ['Tous réseaux sociaux', '30+ publications/mois', '2 shootings/mois', '1 vidéo/mois', 'Publicités incluses', 'Stratégie trimestrielle', 'Accès prioritaire'] }
    ],

    process: [
      { t: 'Audit & Diagnostic', d: "Une analyse approfondie de votre situation actuelle, de vos concurrents et de votre marché. Résultat : une vision claire de vos priorités." },
      { t: 'Stratégie Sur-Mesure', d: "On conçoit votre plan de communication adapté à votre budget, vos objectifs et un calendrier précis." },
      { t: 'Création & Exécution', d: "Notre équipe produit : visuels, vidéos, posts, publicités. Vous validez, nous déployons." },
      { t: 'Mesure & Optimisation', d: "Reporting transparent, ajustements continus. On optimise pour maximiser votre investissement." }
    ],

    campaigns: [
      { client: 'Woodin Togo', f: 'Digital', cat: 'Stratégie Digitale', year: '2023', t: 'Woodin Togo - Domination Digitale', img: '',
        d: "Mandatés pour refondre entièrement la présence digitale de Woodin Togo, nous avons conçu et exécuté une stratégie de contenu complète sur Instagram, Facebook et TikTok. Shooting produit mensuel, calendrier éditorial thématique calé sur les temps forts culturels togolais, gestion quotidienne de la communauté.",
        tags: ['Community Management', 'Stratégie Digitale', 'Contenu'],
        res: [['+340%', 'Engagement'], ['50k+', 'Followers'], ['×4', 'Portée organique'], ['★★★★★', 'Satisfaction']] },
      { client: 'Live Y Dream', f: 'Événementiel', cat: 'Événementiel', year: '2019-2024', t: 'Battle Arena - Compétition Internationale', img: '',
        d: "Événement créé et produit par Live Y Dream. Une compétition de danse urbaine devenue la référence nationale, attirant des danseurs de toute l'Afrique de l'Ouest. Production complète : scénographie, communication, billetterie, couverture audiovisuelle, partenariats.",
        tags: ['Événementiel', 'Production', 'Communication'],
        res: [['1000+', 'Participants'], ['5', 'Éditions'], ['15k+', 'Spectateurs cumulés'], ['N°1', 'Au Togo']] },
      { client: 'Groupe KIK', f: 'Vidéo & Photo', cat: 'Vidéo & Photo', year: '2022', t: 'Groupe KIK - Campagne Publicitaire 360°', img: '',
        d: "Production d'une série de spots publicitaires pour les différentes marques du Groupe KIK. Direction artistique, casting, tournage en studio et en extérieur, post-production et déclinaison pour tous les canaux : TV, réseaux sociaux, affichage.",
        tags: ['Production Vidéo', 'Publicité', 'Multi-canal'],
        res: [['8', 'Spots produits'], ['4', 'Marques couvertes'], ['100%', 'Délais respectés'], ['★★★★★', 'Satisfaction']] },
      { client: 'Krystal Optique', f: 'Identité', cat: 'Identité Visuelle', year: '2023', t: 'Krystal Optique - Nouvelle Identité', img: '',
        d: "Refonte complète de l'identité visuelle de Krystal Optique. Nouveau logo, charte graphique complète, tous les supports de communication, signalétique boutique et habillage réseaux sociaux. Un repositionnement premium qui a transformé la perception de la marque.",
        tags: ['Identité Visuelle', 'Logo', 'Branding'],
        res: [['Logo', 'Redesigné'], ['Charte', 'Complète'], ['RS', 'Habillés'], ['+40%', 'Notoriété']] },
      { client: 'Kramel', f: 'Digital', cat: 'Stratégie Digitale', year: '2022-2023', t: 'Kramel - Croissance Community Management', img: '',
        d: "Gestion complète des réseaux sociaux de Kramel avec une stratégie de contenu orientée conversion. Shooting produits récurrents, animations, publicités Facebook ciblées et campagnes saisonnières. Résultats mesurables et constants.",
        tags: ['Community Management', 'Facebook Ads', 'Contenu'],
        res: [['+280%', 'Croissance'], ['+150%', 'Ventes online'], ['2×', 'Trafic boutique'], ['Top 3', 'Lomé']] },
      { client: 'Lomé By Night', f: 'Événementiel', cat: 'Événementiel', year: '2018-2019', t: 'Lomé By Night - Concept Événementiel', img: '',
        d: "Concept créé par Live Y Dream pour explorer les facettes nocturnes de Lomé. Événement qui a réuni plus de 1 000 personnes autour de la découverte culturelle et gastronomique de la capitale togolaise. Communication virale, vente de billets en ligne, couverture média.",
        tags: ['Concept', 'Événementiel', 'Lomé'],
        res: [['1000+', 'Personnes'], ['2', 'Éditions'], ['100%', 'Sold Out'], ['Viral', 'Sur les RS']] }
    ],

    clients: ['', '', '', '', '', '', '', ''],

    testimonials: [
      { q: "Live Y Dream nous accompagne depuis 3 ans. Ils ont su s'immerger dans notre culture d'entreprise pour nous offrir une identité visuelle incomparable. Leur réactivité est indéniablement leur plus grand atout.", n: 'Directeur Marketing', o: 'Woodin Togo' },
      { q: "Les missions confiées à Live Y Dream ont été réussies. Planification rigoureuse, sérieux et créativité ont apporté notre satisfaction. Je les recommande sans aucune hésitation à qui veut développer sa visibilité.", n: 'Responsable Communication', o: 'Group KIK' },
      { q: "Live Y Dream apporte de bonnes réponses en termes de visibilité. Nos interlocuteurs font preuve d'une excellente capacité d'écoute tant pour la nature de nos besoins que pour le budget alloué.", n: 'Directrice Générale', o: 'Marlia Fab' },
      { q: "Une agence créative, réactive et sympathique qui sait mettre la satisfaction client au coeur de ses préoccupations. À travers les projets réalisés, ils ont su répondre à toutes nos demandes, quelle que soit leur complexité.", n: 'Responsable', o: 'Alloy-team' }
    ],

    articles: [
      { id: 'erreurs-communication-togo', cat: 'Blog', date: '21 septembre 2026', min: 9, author: 'LiveYDream', featured: true, img: '',
        t: 'Les 7 erreurs de communication que font les entreprises togolaises',
        ex: "Au Togo, la communication n'est plus un simple luxe : elle est devenue un pilier du développement des PME. Pourtant, de nombreuses entreprises locales commettent des erreurs récurrentes qui gâchent leur impact.",
        tags: ['Communication', 'erreurs', 'entreprises', 'corriger'],
        body: [
          ['p', "Au Togo, la communication n'est plus un simple luxe : elle est devenue un **pilier du développement des PME**. Pourtant, de nombreuses entreprises locales commettent des erreurs récurrentes qui gâchent leur impact. Voici les sept plus fréquentes, et comment les corriger."],
          ['h2', "1. Communiquer sans stratégie"],
          ['p', "Publier au hasard, quand on y pense, sans objectif ni cible : c'est l'erreur la plus courante. Sans stratégie, chaque publication reste isolée et ne construit rien dans l'esprit de vos clients."],
          ['ul', ["Définissez un objectif clair par trimestre (notoriété, leads, ventes)", "Identifiez précisément votre client idéal", "Planifiez vos contenus dans un calendrier éditorial"]],
          ['h2', "2. Négliger l'identité visuelle"],
          ['p', "Un logo différent sur chaque support, des couleurs qui changent d'un post à l'autre : votre marque paraît instable. Une identité cohérente inspire confiance et se mémorise plus vite."],
          ['quote', "Une marque reconnaissable en une seconde vaut dix publicités mal placées."],
          ['h2', "3. Être présent partout, sans être actif nulle part"],
          ['p', "Ouvrir un compte sur chaque réseau sans pouvoir l'animer donne une image d'abandon. Mieux vaut **deux réseaux bien tenus** que cinq pages endormies. Choisissez là où se trouvent vos clients, Facebook, Instagram, TikTok ou LinkedIn, et soyez-y régulier."],
          ['h2', "4. Ne jamais répondre aux messages"],
          ['p', "Un commentaire sans réponse, un message privé ignoré pendant trois jours : ce sont des clients perdus. Au Togo, WhatsApp et Messenger sont des canaux de vente à part entière."],
          ['tip', "Le conseil LYD", "Fixez-vous une règle simple : toute demande reçoit une réponse sous 24 heures, et sous 1 heure pour les demandes de devis."],
          ['h2', "5. Booster sans cibler"],
          ['p', "Dépenser des milliers de FCFA en boostant une publication à tout le monde, c'est jeter de l'argent. Une publicité efficace repose sur un ciblage précis : zone géographique, âge, centres d'intérêt, comportements d'achat."],
          ['h2', "6. Ne pas mesurer les résultats"],
          ['p', "Sans chiffres, impossible de savoir ce qui fonctionne. Suivez au minimum la portée, l'engagement, les clics et surtout le nombre de demandes générées."],
          ['h2', "7. Vouloir tout faire soi-même"],
          ['p', "Un dirigeant qui gère sa communication entre deux rendez-vous obtient rarement de bons résultats. Déléguer à des professionnels libère votre temps et améliore vos résultats."]
        ] },
      { id: 'guide-agence-lome-2026', cat: 'Blog', date: '16 septembre 2026', min: 7, author: 'LiveYDream', img: '',
        t: "Guide Stratégique 2026 : Comment choisir l'agence de communication idéale à Lomé ?",
        ex: "À l'ère de l'hyper-digitalisation, la communication n'est plus une option, c'est le moteur de votre croissance. À Lomé, le paysage médiatique explose…",
        tags: ['Communication', 'stratégie', 'Afrique de l\'Ouest'],
        body: [
          ['p', "À l'ère de l'hyper-digitalisation, la communication n'est plus une option, c'est **le moteur de votre croissance**. À Lomé, le paysage médiatique explose : agences, freelances, studios. Comment choisir le bon partenaire ?"],
          ['h2', "Commencez par clarifier votre besoin"],
          ['p', "Avant de comparer des devis, sachez ce que vous attendez : plus de visibilité, une nouvelle identité, des ventes en ligne, un événement ? Une agence sérieuse vous posera ces questions avant de vous proposer quoi que ce soit."],
          ['h2', "Les cinq critères qui comptent vraiment"],
          ['ul', ["**Des références vérifiables** : demandez des campagnes réelles, avec des résultats chiffrés", "**Une équipe complète** : stratégie, création, production et suivi sous le même toit", "**Un studio et du matériel** : la qualité de production ne s'improvise pas", "**Une méthode claire** : audit, stratégie, exécution, mesure", "**Une transparence totale** sur les tarifs et les livrables"]],
          ['quote', "Une bonne agence ne vend pas du graphisme : elle vend des clients, de la visibilité et de la crédibilité."],
          ['h2', "Les signaux d'alerte"],
          ['p', "Méfiez-vous des promesses de résultats miracles, des devis flous, des agences qui ne montrent jamais leur travail et de celles qui refusent de parler de mesure des résultats."],
          ['tip', "Le conseil LYD", "Demandez un audit gratuit à deux ou trois agences : la qualité de l'analyse vous en dira plus que n'importe quelle plaquette commerciale."]
        ] },
      { id: 'pme-community-manager', cat: 'Blog', date: '10 septembre 2026', min: 5, author: 'LiveYDream', img: '',
        t: 'Pourquoi les PME au Togo ont besoin d\'un Community Manager professionnel ?',
        ex: "À l'heure où le numérique transforme profondément les habitudes de consommation, la présence en ligne est devenue un véritable enjeu pour les entreprises…",
        tags: ['réseaux sociaux', 'entreprises', 'Communication'],
        body: [
          ['p', "À l'heure où le numérique transforme profondément les habitudes de consommation, la présence en ligne est devenue un véritable enjeu pour les entreprises togolaises. Mais être présent ne suffit pas : il faut **animer, répondre et convertir**. C'est le métier du Community Manager."],
          ['h2', "Ce que fait vraiment un Community Manager"],
          ['p', "Contrairement à une idée reçue, il ne se contente pas de publier. Il pilote la relation entre votre marque et sa communauté."],
          ['ul', ["Il construit une ligne éditoriale et un calendrier de contenus", "Il crée ou coordonne les visuels et les vidéos", "Il modère, répond et anime la communauté au quotidien", "Il analyse les résultats et ajuste la stratégie"]],
          ['h2', "Pourquoi l'improvisation coûte cher"],
          ['p', "Confier les réseaux sociaux à un stagiaire ou les gérer soi-même entre deux rendez-vous donne des publications irrégulières, des messages sans réponse et une image de marque floue. Une communication bâclée fait plus de mal que rien."],
          ['quote', "Vos clients comparent votre présence en ligne avant de vous appeler."],
          ['h2', "Les bénéfices concrets pour une PME"],
          ['ul', ["**Plus de visibilité** auprès de clients qui ne vous connaissaient pas", "**Plus de confiance** grâce à une image professionnelle et régulière", "**Plus de demandes** : un message, un appel, une commande", "**Du temps gagné** pour vous concentrer sur votre métier"]],
          ['tip', "Le conseil LYD", "Une formule d'abonnement tout-en-un permet de démarrer avec un budget maîtrisé : stratégie, contenus, modération et rapport mensuel inclus."]
        ] },
      { id: 'pme-cm-pro', cat: 'Blog', date: '16 juin 2026', min: 4, author: 'Alain ANDJAO', img: '',
        t: 'Pourquoi votre PME au Togo a besoin d\'un community manager professionnel',
        ex: "Aujourd'hui, être présent sur les réseaux sociaux ne suffit plus. Les consommateurs recherchent des entreprises visibles, crédibles et réactives…",
        tags: ['réseaux sociaux', 'marque', 'clients'] },
      { id: 'sept-erreurs', cat: 'Blog', date: '16 juin 2026', min: 4, author: 'Alain ANDJAO', img: '',
        t: 'Les 7 erreurs de communication que font les entreprises togolaises',
        ex: "Dans un environnement économique de plus en plus concurrentiel, la communication n'est plus un luxe pour les entreprises togolaises…",
        tags: ['erreurs', 'Communication', 'étapes'] },
      { id: 'abonnes-clients-fideles', cat: 'Blog', date: '18 mai 2026', min: 4, author: 'Alain ANDJAO', img: '',
        t: 'Comment transformer vos abonnés en clients fidèles (sans être agressif)',
        ex: "Avoir des abonnés sur les réseaux sociaux est une chose. Les transformer en clients fidèles en est une autre…",
        tags: ['clients', 'réseaux sociaux', 'Astuces'] },
      { id: 'marketing-digital-afrique', cat: 'Blog', date: '18 mai 2026', min: 4, author: 'Alain ANDJAO', img: '',
        t: 'Marketing digital en Afrique : opportunité énorme ou illusion ?',
        ex: "Le marketing digital est souvent présenté comme une révolution pour les entreprises africaines. Réseaux sociaux, publicité en ligne, création de contenu…",
        tags: ['Marketing digital', 'Afrique de l\'Ouest', 'Publicité'] },
      { id: 'entreprise-invisible-30-jours', cat: 'Blog', date: '11 mai 2026', min: 3, author: 'Alain ANDJAO', img: '',
        t: 'Votre entreprise est invisible en ligne ? Voici comment changer ça en 30 jours',
        ex: "Aujourd'hui, une entreprise qui n'est pas visible en ligne perd des opportunités tous les jours. Clients potentiels, partenaires, prospects…",
        tags: ['30 jours', 'changer', 'marque'] },
      { id: 'contenus-viraux', cat: 'Blog', date: '11 mai 2026', min: 4, author: 'Alain ANDJAO', img: '',
        t: 'Le secret des contenus viraux : ce que les grandes marques font différemment',
        ex: "Chaque jour, des milliers de contenus sont publiés sur les réseaux sociaux. Pourtant, seuls quelques-uns captent réellement l'attention…",
        tags: ['contenus viraux', 'grandes marques', 'secret'] }
    ],

    about: {
      heroImg: '',
      big: '10+', bigLabel: 'Ans au service de vos rêves', bigSub: 'Depuis 2013',
      title: 'Une décennie à construire l\'excellence',
      paras: [
        "Fondée en 2013 à Lomé, Live Y Dream est née d'une conviction simple : les meilleures entreprises africaines méritent une communication à la hauteur de leurs ambitions.",
        "En 10 ans, nous avons accompagné plus de 200 marques, des PME locales aux multinationales comme UNICEF, UBA et Ecobank, avec une seule obsession : des résultats concrets et mesurables.",
        "Aujourd'hui, Live Y Dream c'est une équipe de passionnés, un studio de production équipé, une présence dans 4 pays (Togo, Bénin, Gabon, Mali) et une vision panafricaine qui ne fait que commencer."
      ],
      values: [
        { t: 'Excellence', d: "Chaque livrable doit dépasser les attentes. C'est notre standard, pas notre exception." },
        { t: 'Résultats', d: "Chaque action doit générer un impact mesurable. On ne fait pas de la com pour faire de la com." },
        { t: 'Innovation', d: "L'Afrique évolue vite. Nous évoluons encore plus vite pour vous garder en avance." },
        { t: 'Loyauté', d: "Vos intérêts passent avant les nôtres. Votre succès est notre succès." }
      ],
      countries: [['Lomé', 'Togo · Siège'], ['Cotonou', 'Bénin'], ['Libreville', 'Gabon'], ['Bamako', 'Mali']],
      milestones: [
        { y: '2013', t: 'Fondation de Live Y Dream', d: "Naissance de l'agence à Lomé avec une vision claire : créer l'agence de communication de référence en Afrique de l'Ouest." },
        { y: '2015', t: 'Premiers grands comptes', d: "Signature des premiers contrats avec des marques nationales majeures. L'agence prouve sa capacité à délivrer à grande échelle." },
        { y: '2018', t: 'Lomé By Night, premier concept propriétaire', d: "Création et production du premier concept événementiel interne de l'agence. Plus de 1000 participants, preuve de la valeur au-delà des services." },
        { y: '2019', t: 'Battle Arena & expansion régionale', d: "Lancement de Battle Arena et ouverture des premiers bureaux au Bénin. L'agence commence son expansion panafricaine." },
        { y: '2022', t: 'Partenariats institutionnels', d: "Signature de contrats avec UNICEF, GIZ et d'autres organisations internationales. La qualité de LYD reconnue au niveau mondial." },
        { y: '2023', t: '10 ans, nouveau chapitre', d: "Célébration d'une décennie. Lancement de Wakabi (tourisme) et restructuration vers un groupe panafricain. Les 10 prochaines années commencent." }
      ]
    }
  };

  function clone(o) { return JSON.parse(JSON.stringify(o)); }
  function load() {
    try { var raw = localStorage.getItem(KEY); if (raw) return JSON.parse(raw); } catch (e) {}
    return {};
  }
  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  var CMS = {
    esc: esc,
    get: function (key) {
      var saved = load();
      if (saved[key] !== undefined) return saved[key];
      return DEFAULTS[key] === undefined ? null : clone(DEFAULTS[key]);
    },
    set: function (key, value) {
      var saved = load(); saved[key] = value;
      try { localStorage.setItem(KEY, JSON.stringify(saved)); } catch (e) {}
    },
    exportJSON: function () { return JSON.stringify(load(), null, 2); },
    importJSON: function (txt) { localStorage.setItem(KEY, JSON.stringify(JSON.parse(txt))); },
    reset: function () { try { localStorage.removeItem(KEY); } catch (e) {} },
    qs: function (name) { return new URLSearchParams(location.search).get(name); },

    ph: function (src, label, alt) {
      return src ? '<img src="' + esc(src) + '" alt="' + esc(alt || label || '') + '">' : '<span class="ph-l">' + esc(label || '') + '</span>';
    },
    contactUrl: function (need, extra) {
      return 'contact.html?service=' + encodeURIComponent(need || '') + (extra || '');
    }
  };

  var NAV = [
    ['services.html', 'Services'], ['campagnes.html', 'Campagnes'],
    ['blog.html', 'Blog'], ['a-propos.html', 'À propos'], ['contact.html', 'Contact']
  ];

  CMS.header = function (active) {
    var s = CMS.get('settings');
    var links = NAV.map(function (n) {
      return '<a href="' + n[0] + '"' + (n[0] === active ? ' class="on"' : '') + '>' + n[1] + '</a>';
    }).join('');
    return '<header class="hd dk"><div class="w">' +
      '<a class="logo" href="index.html">' + esc(s.brand) + '</a>' +
      '<nav id="nav">' + links + '</nav>' +
      '<a class="btn cta" href="contact.html">Devis gratuit</a>' +
      '<button class="burger" aria-label="Menu" onclick="document.getElementById(\'nav\').classList.toggle(\'open\')">☰</button>' +
      '</div></header>';
  };

  CMS.footer = function () {
    var s = CMS.get('settings'), sv = CMS.get('services');
    var svc = sv.map(function (x, i) { return '<li><a href="services.html#s' + (i + 1) + '">' + esc(x.cat) + '</a></li>'; }).join('') +
      '<li><a href="services.html#tarifs">Abonnement PME</a></li>';
    return '<footer class="ft dk"><div class="w">' +
      '<div class="ft-g">' +
      '<div><a class="logo" href="index.html">' + esc(s.brand) + '</a><p>' + esc(s.baseline) + '</p></div>' +
      '<div><h5>Services</h5><ul>' + svc + '</ul></div>' +
      '<div><h5>Agence</h5><ul><li><a href="a-propos.html">Notre histoire</a></li><li><a href="a-propos.html#valeurs">Notre équipe</a></li><li><a href="campagnes.html">Nos réalisations</a></li><li><a href="blog.html">Blog &amp; Ressources</a></li><li><a href="contact.html?service=Autre">Rejoindre LYD</a></li></ul></div>' +
      '<div><h5>Contact</h5><ul><li><a href="tel:' + esc(s.phone.replace(/\s/g, '')) + '">' + esc(s.phone) + '</a></li><li><a href="mailto:' + esc(s.email) + '">' + esc(s.email) + '</a></li><li><a href="' + esc(s.whatsapp) + '" target="_blank" rel="noopener">WhatsApp direct</a></li><li><a href="contact.html">Demander un devis</a></li></ul></div>' +
      '</div>' +
      '<div class="ft-b"><span>' + new Date().getFullYear() + ' Live Y Dream · Tous droits réservés · Lomé, Togo</span><span>Mentions légales · Confidentialité</span></div>' +
      '</div></footer>';
  };

  CMS.statsBand = function () {
    var st = CMS.get('settings').stats;
    var plus = function (n) { return /^\d+$/.test(n) ? n + '+' : n; };
    var items = [
      [st[1].n, 'Marques accompagnées'], [st[0].n, "Années d'expérience"],
      [st[2].n, 'Pays couverts'], [plus(st[3].n), "Experts dans l'équipe"]
    ];
    return '<section class="band dk"><div class="w band-g">' + items.map(function (x) {
      return '<div><div class="n">' + esc(x[0]) + '</div><div class="l">' + esc(x[1]) + '</div></div>';
    }).join('') + '</div></section>';
  };

  CMS.mount = function (active) {
    document.querySelectorAll('[data-lyd]').forEach(function (el) {
      var t = el.getAttribute('data-lyd');
      if (t === 'header') el.outerHTML = CMS.header(active);
      else if (t === 'footer') el.outerHTML = CMS.footer();
      else if (t === 'stats') el.outerHTML = CMS.statsBand();
    });
  };

  window.CMS = CMS;
})();
