/* Live Y Dream - moteur de données (base Supabase, brouillons dans localStorage) + composants partagés */
(function () {
  var KEY = 'lyd_cms_v1', MEDIA_KEY = 'lyd_media_v1', PREVIEW_KEY = 'lyd_preview';
  /* Seule l'administration, à cette adresse, peut ouvrir un aperçu des changements non publiés */
  var ADMIN_ORIGINS = ['https://liveydream-admin.vercel.app'];
  /* Version en ligne : la table site_content de la base, chargée avant que la page s'affiche */
  var PUB = {}, PUB_CACHE = 'lyd_pub_cache', readyFns = [], isReady = false;

  /* Structure vide : le contenu est dans la base (site_content, voir database/seed.sql) */
  var DEFAULTS = {
    settings: {
      brand: "",
      whatsapp: "",
      email: "",
      phone: "",
      baseline: "",
      hero: {
        title: "",
        text: "",
        image: ""
      },
      stats: [],
      cta: {
        title: "",
        text: ""
      }
    },
    contact: {
      address: [],
      phones: [],
      emails: [],
      hours: [],
      socials: [],
      needs: [],
      budgets: []
    },
    problems: [],
    services: [],
    plan: {
      k: "",
      t: "",
      d: "",
      price: "",
      cta: ""
    },
    plans: [],
    process: [],
    campaigns: [],
    jobs: [],
    careers: {
      why: [],
      postes: []
    },
    blogTexts: {
      auditT: "",
      auditD: "",
      auditBtn: "",
      ctaK: "",
      ctaT: "",
      ctaD: "",
      ctaBtn: "",
      ctaWa: "",
      bio: ""
    },
    forms: {
      email: "",
      jobsEmail: ""
    },
    discussion: {
      enabled: true,
      moderate: true
    },
    texts: {},
    seo: {},
    clients: [],
    testimonials: [],
    articles: [],
    about: {
      heroImg: "",
      big: "",
      bigLabel: "",
      bigSub: "",
      title: "",
      paras: [],
      values: [],
      countries: [],
      milestones: []
    }
  };

  /* Clés de contenu publiques (jamais les messages ni les candidatures) */
  var CONTENT_KEYS = ['settings', 'contact', 'problems', 'services', 'plan', 'plans', 'process', 'campaigns', 'jobs', 'careers', 'blogTexts', 'forms', 'texts', 'seo', 'clients', 'testimonials', 'articles', 'about', 'discussion'];
  var FILTERED_KEYS = { articles: 1, campaigns: 1, jobs: 1 };
  /* Données de visiteurs : gardées lors d'un retour à la version en ligne, jamais publiées telles quelles */
  var PRIVATE_KEYS = ['messages', 'applications', 'comments'];
  var mediaCache = null;

  function clone(o) { return JSON.parse(JSON.stringify(o)); }
  /* Pendant un aperçu, les données vivent dans l'onglet (sessionStorage) et disparaissent avec lui */
  function store() {
    try { return sessionStorage.getItem(PREVIEW_KEY) ? sessionStorage : localStorage; } catch (e) { return null; }
  }
  function load() {
    try { var raw = store().getItem(KEY); if (raw) return JSON.parse(raw); } catch (e) {}
    return {};
  }
  function base(key) { return PUB[key] !== undefined ? PUB[key] : DEFAULTS[key]; }

  function safeUrl(u, forImg) {
    var raw = String(u == null ? '' : u).trim();
    var s = raw.replace(/[\u0000-\u0020\u007f-\u009f]+/g, '');
    var m = /^([a-z][a-z0-9+.-]*):/i.exec(s);
    if (!m) return raw;
    var p = m[1].toLowerCase();
    if (p === 'http' || p === 'https') return s;
    if (forImg) return p === 'media' || /^data:image\//i.test(s) ? s : '';
    return p === 'mailto' || p === 'tel' ? s : '';
  }

  /* Nettoyage du HTML saisi dans l'admin ou importé : liste blanche stricte */
  var TAGS = { P: 1, BR: 1, STRONG: 1, B: 1, EM: 1, I: 1, U: 1, S: 1, STRIKE: 1, H2: 1, H3: 1, H4: 1, UL: 1, OL: 1, LI: 1, BLOCKQUOTE: 1, A: 1, IMG: 1, DIV: 1, SPAN: 1, HR: 1, FIGURE: 1, FIGCAPTION: 1 };
  var DROP = /^(SCRIPT|STYLE|IFRAME|OBJECT|EMBED|SVG|MATH|TEMPLATE|NOSCRIPT|LINK|META|BASE|TITLE|HEAD|FORM|INPUT|BUTTON|TEXTAREA|SELECT|OPTION|VIDEO|AUDIO|SOURCE|CANVAS|APPLET|FRAME|FRAMESET)$/;
  var CLASSES = { tip: 1, k: 1 };

  function cleanNode(parent) {
    [].slice.call(parent.childNodes).forEach(function (n) {
      if (n.nodeType === 3) return;
      if (n.nodeType !== 1) { parent.removeChild(n); return; }
      var tag = n.tagName.toUpperCase();
      if (DROP.test(tag)) { parent.removeChild(n); return; }
      if (!TAGS[tag]) {
        cleanNode(n);
        while (n.firstChild) parent.insertBefore(n.firstChild, n);
        parent.removeChild(n);
        return;
      }
      [].slice.call(n.attributes).forEach(function (a) {
        var name = a.name.toLowerCase(), keep = false;
        if (tag === 'A') keep = name === 'href' || name === 'target' || name === 'title';
        else if (tag === 'IMG') keep = name === 'src' || name === 'alt' || name === 'title';
        else if (name === 'class') keep = CLASSES[a.value] === 1;
        if (!keep) n.removeAttribute(a.name);
      });
      if (tag === 'A') {
        var href = safeUrl(n.getAttribute('href'));
        if (href) n.setAttribute('href', href); else n.removeAttribute('href');
        if (n.getAttribute('target') === '_blank') n.setAttribute('rel', 'noopener noreferrer'); else n.removeAttribute('target');
      }
      if (tag === 'IMG') {
        var src = safeUrl(n.getAttribute('src'), true);
        if (!src) { parent.removeChild(n); return; }
        n.setAttribute('src', src);
      }
      cleanNode(n);
    });
  }
  function sanitizedBody(html) {
    var body = new DOMParser().parseFromString('<!doctype html><body>' + String(html == null ? '' : html), 'text/html').body;
    cleanNode(body);
    return body;
  }
  function slugify(s) {
    return String(s).toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
  }
  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  window.addEventListener('storage', function (ev) {
    if (ev.key === MEDIA_KEY || ev.key === null) mediaCache = null;
  });

  var CMS = {
    esc: esc,
    get: function (key) {
      var saved = load(), v;
      if (saved[key] !== undefined) v = saved[key];
      else { var b = base(key); v = b === undefined ? null : clone(b); }
      if (key === 'settings' && v) v.whatsapp = safeUrl(v.whatsapp) || '#';
      return v;
    },
    /* Renvoie false si le navigateur n'a plus de place */
    set: function (key, value) {
      var saved = load(), b = base(key);
      if (b !== undefined && JSON.stringify(b) === JSON.stringify(value)) delete saved[key]; else saved[key] = value;
      try { store().setItem(KEY, JSON.stringify(saved)); return true; } catch (e) { return false; }
    },
    isContentKey: function (key) { return CONTENT_KEYS.indexOf(key) > -1; },
    uid: function () { return Date.now().toString(36) + Math.random().toString(36).slice(2, 8); },
    slugify: slugify,
    /* Sauvegarde complète ; les messages personnels seulement sur demande */
    exportJSON: function (withMessages) {
      var data = load();
      if (!withMessages) PRIVATE_KEYS.forEach(function (k) { delete data[k]; });
      return JSON.stringify({ app: 'live-y-dream', version: 1, exportedAt: new Date().toISOString(), data: data, media: CMS.media().filter(function (m) { return !m.pub; }) }, null, 2);
    },
    /* Lève une erreur si le fichier n'est pas une sauvegarde valide ; n'écrit rien dans ce cas */
    importJSON: function (txt) {
      var obj = JSON.parse(txt);
      if (!obj || typeof obj !== 'object' || obj.app !== 'live-y-dream' || !obj.data || typeof obj.data !== 'object') throw new Error('format');
      var saved = load(), before = JSON.stringify(saved), keys = [];
      CONTENT_KEYS.forEach(function (k) { delete saved[k]; });
      Object.keys(obj.data).forEach(function (k) {
        if (!CMS.isContentKey(k) && PRIVATE_KEYS.indexOf(k) < 0 && k !== 'discussion') return;
        var ref = base(k), v = obj.data[k];
        if (ref !== undefined && (Array.isArray(ref) !== Array.isArray(v) || typeof ref !== typeof v)) throw new Error('format');
        saved[k] = v; keys.push(k);
      });
      store().setItem(KEY, JSON.stringify(saved));
      if (Array.isArray(obj.media)) {
        var media = obj.media.filter(function (m) { return m && typeof m.id === 'string' && typeof m.src === 'string'; });
        if (!CMS.saveMedia(media)) {
          store().setItem(KEY, before);
          var full = new Error('quota');
          full.name = 'QuotaExceededError';
          throw full;
        }
      }
      return keys;
    },
    /* Retire les modifications locales de contenu ; garde les messages et les médias */
    reset: function () {
      var saved = load();
      CONTENT_KEYS.forEach(function (k) { delete saved[k]; });
      try { store().setItem(KEY, JSON.stringify(saved)); } catch (e) {}
    },
    qs: function (name) { return new URLSearchParams(location.search).get(name); },

    /* Préfixe des chemins relatifs : l'adresse du site dans l'admin */
    root: '',
    media: function () {
      if (!mediaCache) {
        try { mediaCache = JSON.parse(store().getItem(MEDIA_KEY)) || []; } catch (e) { mediaCache = []; }
      }
      var pub = PUB.media || {}, ids = {};
      mediaCache.forEach(function (m) { ids[m.id] = 1; });
      return mediaCache.concat(Object.keys(pub).filter(function (id) { return !ids[id]; }).map(function (id) {
        return { id: id, name: pub[id].name || id, alt: pub[id].alt || '', src: pub[id].src, pub: true };
      }));
    },
    saveMedia: function (list) {
      var own = list.filter(function (m) { return !m.pub; });
      try { store().setItem(MEDIA_KEY, JSON.stringify(own)); mediaCache = own; return true; } catch (e) { return false; }
    },
    mediaItem: function (id) { return CMS.media().filter(function (m) { return m.id === id; })[0] || null; },
    /* URL d'affichage d'une image : résout media:ID, refuse les protocoles dangereux */
    src: function (v) {
      var u = safeUrl(v, true);
      if (!u) return '';
      var m = /^media:(.+)$/.exec(u);
      if (m) { var it = CMS.mediaItem(m[1]); return it ? it.src : ''; }
      if (/^(data:|https?:|\/)/i.test(u)) return u;
      return CMS.root + u;
    },
    href: function (u) { return safeUrl(u) || '#'; },
    sanitize: function (html) { return sanitizedBody(html).innerHTML; },
    published: function (list) {
      return (list || []).filter(function (x) { return x.status !== 'brouillon'; });
    },

    ph: function (src, label, alt) {
      var u = CMS.src(src);
      return u ? '<img src="' + esc(u) + '" alt="' + esc(alt || label || '') + '">' : '<span class="ph-l">' + esc(label || '') + '</span>';
    },
    contactUrl: function (need, extra) {
      return 'contact.html?service=' + encodeURIComponent(need || '') + (extra || '');
    }
  };

  /* Corps d'un article : HTML de l'éditeur, ou blocs historiques convertis */
  CMS.blocksToHtml = function (blocks) {
    var fmt = function (s) { return esc(s).replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>'); };
    return (blocks || []).map(function (b) {
      switch (b[0]) {
        case 'h2': return '<h2>' + fmt(b[1]) + '</h2>';
        case 'ul': return '<ul>' + b[1].map(function (x) { return '<li>' + fmt(x) + '</li>'; }).join('') + '</ul>';
        case 'quote': return '<blockquote>' + fmt(b[1]) + '</blockquote>';
        case 'tip': return '<div class="tip"><span class="k">' + esc(b[1]) + '</span><p>' + fmt(b[2]) + '</p></div>';
        default: return '<p>' + fmt(b[1]) + '</p>';
      }
    }).join('');
  };
  CMS.articleSource = function (a) {
    return a.html ? CMS.sanitize(a.html) : CMS.blocksToHtml(a.body);
  };
  CMS.articleHtml = function (a) {
    var src = CMS.articleSource(a) || '<p>' + esc(String(a.ex || '').replace(/…$/, '.')) + '</p>';
    var body = sanitizedBody(src), toc = [], seen = {};
    body.querySelectorAll('img').forEach(function (im) {
      var u = CMS.src(im.getAttribute('src'));
      if (u) im.setAttribute('src', u); else im.parentNode.removeChild(im);
    });
    body.querySelectorAll('h2,h3').forEach(function (h) {
      var id = slugify(h.textContent) || 'section', n = seen[id] = (seen[id] || 0) + 1;
      if (n > 1) id += '-' + n;
      h.setAttribute('id', id);
      toc.push([id, h.textContent, h.tagName === 'H3']);
    });
    return { html: body.innerHTML, toc: toc };
  };

  /* Contenu public envoyé dans la base par « Publier le site » : ni brouillons, ni messages, ni comptes */
  CMS.publishData = function () {
    var out = {}, media = {};
    CONTENT_KEYS.forEach(function (k) {
      var v = CMS.get(k);
      if (FILTERED_KEYS[k]) v = CMS.published(v);
      if (JSON.stringify(v) !== JSON.stringify(DEFAULTS[k])) out[k] = v;
    });
    (JSON.stringify(out).match(/media:[a-z0-9]+/gi) || []).forEach(function (ref) {
      var id = ref.slice(6), it = CMS.mediaItem(id);
      if (it) media[id] = { src: it.src, alt: it.alt || '', name: it.name || '' };
    });
    if (Object.keys(media).length) out.media = media;
    return out;
  };
  /* Commentaires approuvés d'un article, regroupés sous le commentaire de départ */
  CMS.commentThreads = function (articleId, extra) {
    var seen = {}, list = (CMS.get('comments') || []).concat(extra || []).filter(function (c) {
      if (c.article !== articleId || c.status !== 'approved' || seen[c.id]) return false;
      return (seen[c.id] = true);
    }).sort(function (a, b) { return String(a.date).localeCompare(String(b.date)); });
    var byId = {}, threads = [];
    list.forEach(function (c) { byId[c.id] = { c: c, replies: [] }; });
    list.forEach(function (c) {
      var top = c;
      for (var i = 0; i < 50 && top.parent && byId[top.parent]; i++) top = byId[top.parent].c;
      if (top === c) threads.push(byId[c.id]); else byId[top.id].replies.push(c);
    });
    return { total: list.length, threads: threads };
  };
  CMS.addComment = function (data) {
    var box = CMS.get('comments') || [];
    var c = { id: CMS.uid(), article: data.article, parent: data.parent || '', author: data.author, email: data.email, content: data.content, status: CMS.get('discussion').moderate === false ? 'approved' : 'pending', date: new Date().toISOString() };
    box.push(c);
    return CMS.set('comments', box) ? c : null;
  };
  /* Dans la base, un article est retrouvé par son adresse (slug) */
  function slugOf(id) { var s = String(id || ''); return /^[a-z0-9]+(-[a-z0-9]+)*$/.test(s) ? s : slugify(s); }
  CMS.articleSlug = slugOf;
  var dbArticles = {};
  function dbArticle(id) {
    var slug = slugOf(id);
    if (!dbArticles[slug]) {
      dbArticles[slug] = DB.select('articles', 'select=id,allow_comments&slug=eq.' + encodeURIComponent(slug), { anon: true })
        .then(function (r) { return (r && r[0]) || null; }, function (e) { delete dbArticles[slug]; throw e; });
    }
    return dbArticles[slug];
  }
  CMS.loadComments = function (articleId) {
    if (!window.DB) return Promise.resolve([]);
    return DB.select('comments', 'select=id,parent_id,author_name,content,created_at,articles!inner(slug)&articles.slug=eq.' + encodeURIComponent(slugOf(articleId)) + '&order=created_at.asc', { anon: true })
      .then(function (rows) {
        return (rows || []).map(function (c) {
          return { id: c.id, article: articleId, parent: c.parent_id || '', author: c.author_name, content: c.content, status: 'approved', date: c.created_at };
        });
      });
  };
  var UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  CMS.postComment = function (data) {
    if (!window.DB) return Promise.reject(new Error('Base de données indisponible.'));
    return dbArticle(data.article).then(function (art) {
      if (!art || art.allow_comments === false) {
        var closed = new Error('Les commentaires ne sont pas encore ouverts sur cet article.');
        closed.code = 'closed';
        throw closed;
      }
      return DB.insert('comments', {
        article_id: art.id,
        parent_id: UUID.test(data.parent || '') ? data.parent : null,
        author_name: String(data.author).slice(0, 120),
        author_email: data.email,
        content: String(data.content).slice(0, 5000)
      }, { anon: true });
    }).then(function () {
      return { status: CMS.get('discussion').moderate === false ? 'approved' : 'pending' };
    });
  };

  /* Chargement du contenu publié ; en cas de coupure, la dernière copie reçue */
  function setPublished(data) { PUB = data || {}; mediaCache = null; }
  CMS.setPublished = setPublished;
  CMS.loadPublished = function () {
    if (!window.DB) return Promise.reject(new Error('Base de données indisponible.'));
    return DB.select('site_content', 'select=key,value&is_public=eq.true', { anon: true }).then(function (rows) {
      var data = {};
      (rows || []).forEach(function (r) { data[r.key] = r.value; });
      setPublished(data);
      try { localStorage.setItem(PUB_CACHE, JSON.stringify(data)); } catch (e) {}
      return data;
    });
  };
  CMS.ready = function (fn) { if (isReady) fn(); else readyFns.push(fn); };
  window.LYD_WAIT = true;
  CMS.loadPublished().catch(function (e) {
    try { console.error('[LYD] Contenu du site non chargé : ' + e.message); } catch (x) {}
    try { var copy = JSON.parse(localStorage.getItem(PUB_CACHE)); if (copy) setPublished(copy); } catch (x) {}
    CMS.offline = true;
  }).then(function () {
    isReady = true;
    window.LYD_WAIT = false;
    readyFns.splice(0).forEach(function (fn) { fn(); });
    if (window.LYD_CHECK) setTimeout(window.LYD_CHECK, 400);
  });

  CMS.isPublished = function () {
    return JSON.stringify(CMS.publishData()) === JSON.stringify(PUB);
  };
  CMS.storageUsed = function () {
    var n = 0;
    try {
      Object.keys(localStorage).forEach(function (k) { if (k.indexOf('lyd_') === 0) n += k.length + (localStorage.getItem(k) || '').length; });
    } catch (e) {}
    return n;
  };

  /* Envoi d'un formulaire : enregistré dans la base (boîte Messages de l'admin), et par email si une adresse est réglée.
     Résultat : { sent: true } si l'agence l'a reçu, { sent: false } sinon. */
  function cut(v, n) { return String(v || '').trim().slice(0, n); }
  var FORM_TABLES = {
    messages: { table: 'contact_messages', row: function (d) {
      return { name: cut(d.nom, 120), company: cut(d.entreprise, 200), email: d.email, whatsapp: cut(d.whatsapp, 40), need: cut(d.besoin, 200), budget: cut(d.budget, 100), message: cut(d.message, 5000) };
    } },
    applications: { table: 'job_applications', row: function (d) {
      return { applied_for: cut(d.poste, 200), name: cut(d.nom, 120), email: d.email, whatsapp: cut(d.whatsapp, 40), cv_url: /^https?:\/\//i.test(d.cv || '') ? cut(d.cv, 500) : null, message: cut(d.message, 5000) };
    } }
  };
  CMS.sendForm = function (kind, data, subject) {
    var f = CMS.get('forms') || {};
    var to = String((kind === 'applications' && f.jobsEmail) || f.email || '').trim();
    function keep() {
      var box = CMS.get(kind) || [];
      box.push(data);
      CMS.set(kind, box);
    }
    var t = FORM_TABLES[kind];
    var stored = t && window.DB ? DB.insert(t.table, t.row(data), { anon: true }).then(function () { return true; }, function (e) {
      try { console.error('[LYD] Formulaire non enregistré dans la base : ' + e.message); } catch (x) {}
      return false;
    }) : Promise.resolve(false);
    return stored.then(function (inDb) {
      if (!to) {
        if (!inDb) keep();
        return { sent: inDb };
      }
      return mail().then(function (r) {
        if (!r.sent && !inDb) keep();
        return { sent: r.sent || inDb, failed: !r.sent && !inDb };
      });
    });
    function mail() {
    var payload = {};
    Object.keys(data).forEach(function (k) { if (data[k] && k !== 'id') payload[k] = data[k]; });
    payload._subject = subject;
    payload._replyto = data.email;
    payload._template = 'table';
    payload._captcha = 'false';
    return fetch('https://formsubmit.co/ajax/' + encodeURIComponent(to), {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
      body: JSON.stringify(payload)
    }).then(function (r) { return r.json(); }).then(function (j) {
      if (String(j.success) !== 'true') throw new Error('refus');
      return { sent: true };
    }).catch(function () {
      return { sent: false };
    });
    }
  };

  var NAV = [
    ['services.html', 'Services'], ['campagnes.html', 'Campagnes'],
    ['blog.html', 'Blog'], ['a-propos.html', 'À propos'], ['carrieres.html', 'Carrières'], ['contact.html', 'Contact']
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
      '<div><h5>Agence</h5><ul><li><a href="a-propos.html">Notre histoire</a></li><li><a href="a-propos.html#valeurs">Notre équipe</a></li><li><a href="campagnes.html">Nos réalisations</a></li><li><a href="blog.html">Blog &amp; Ressources</a></li><li><a href="carrieres.html">Rejoindre LYD</a></li></ul></div>' +
      '<div><h5>Contact</h5><ul><li><a href="tel:' + esc(s.phone.replace(/\s/g, '')) + '">' + esc(s.phone) + '</a></li><li><a href="mailto:' + esc(s.email) + '">' + esc(s.email) + '</a></li><li><a href="' + esc(s.whatsapp) + '" target="_blank" rel="noopener">WhatsApp direct</a></li><li><a href="contact.html">Demander un devis</a></li></ul></div>' +
      '</div>' +
      '<div class="ft-b"><span>' + new Date().getFullYear() + ' Live Y Dream · Tous droits réservés · Lomé, Togo</span><span>Mentions légales · Confidentialité</span></div>' +
      '</div></footer>';
  };

  CMS.statsBand = function () {
    var st = CMS.get('settings').stats || [];
    if (st.length < 4) return '';
    var plus = function (n) { return /^\d+$/.test(n) ? n + '+' : n; };
    var items = [
      [st[1].n, st[1].b || 'Marques accompagnées'], [st[0].n, st[0].b || "Années d'expérience"],
      [st[2].n, st[2].b || 'Pays couverts'], [plus(st[3].n), st[3].b || "Experts dans l'équipe"]
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
    CMS.applyTexts(active);
    CMS.topBtn();
    if (CMS.isPreview()) CMS.previewBar();
  };

  /* Textes modifiés dans l'admin : le HTML de la page reste la version par défaut */
  CMS.applyTexts = function (active) {
    var t = CMS.get('texts') || {};
    document.querySelectorAll('[data-t]').forEach(function (el) {
      var v = t[el.getAttribute('data-t')];
      if (v) el.innerHTML = CMS.sanitize(v);
    });
    var seo = (CMS.get('seo') || {})[String(active || '').replace(/\.html$/, '')];
    if (seo && seo.title) document.title = seo.title;
    if (seo && seo.desc) {
      var md = document.querySelector('meta[name="description"]');
      if (md) md.setAttribute('content', seo.desc);
    }
  };

  /* Bouton flottant « remonter en haut » — présent sur toutes les pages */
  CMS.topBtn = function () {
    if (document.getElementById('toTop')) return;
    var b = document.createElement('button');
    b.id = 'toTop'; b.type = 'button';
    b.setAttribute('aria-label', 'Remonter en haut');
    b.innerHTML = '↑';
    b.addEventListener('click', function () { window.scrollTo({ top: 0, behavior: 'smooth' }); });
    document.body.appendChild(b);
    var toggle = function () {
      b.classList.toggle('show', (window.pageYOffset || document.documentElement.scrollTop) > 150);
      /* s'inverse (blanc) quand il survole une zone noire (.dk) */
      var r = b.getBoundingClientRect(), cy = r.top + r.height / 2, cx = r.left + r.width / 2, dark = false;
      document.querySelectorAll('.dk').forEach(function (el) {
        var q = el.getBoundingClientRect();
        if (cy >= q.top && cy <= q.bottom && cx >= q.left && cx <= q.right) dark = true;
      });
      b.classList.toggle('inv', dark);
    };
    window.addEventListener('scroll', toggle, { passive: true });
    toggle();
  };

  /* ---------- Aperçu ouvert depuis l'admin (projet séparé, autre adresse) ---------- */
  CMS.overlay = function () {
    var d = load();
    delete d.messages;
    delete d.applications;
    return d;
  };
  CMS.isPreview = function () {
    try { return !!sessionStorage.getItem(PREVIEW_KEY); } catch (e) { return false; }
  };
  CMS.previewBar = function () {
    if (document.getElementById('lyd-pv')) return;
    var bar = document.createElement('div'), quit = document.createElement('button');
    bar.id = 'lyd-pv';
    bar.className = 'lyd-pv';
    bar.setAttribute('role', 'status');
    bar.appendChild(document.createTextNode('Aperçu : modifications pas encore publiées'));
    quit.type = 'button';
    quit.textContent = "Quitter l'aperçu";
    quit.addEventListener('click', function () {
      try { [KEY, MEDIA_KEY, PREVIEW_KEY].forEach(function (k) { sessionStorage.removeItem(k); }); } catch (e) {}
      location.href = location.pathname + location.search.replace(/([?&])preview=1&?/, '$1').replace(/[?&]$/, '');
    });
    bar.appendChild(quit);
    document.body.appendChild(bar);
  };
  /* La page ouverte par l'admin le signale, et n'accepte les données que de l'adresse de l'admin */
  if (/[?&]preview=1/.test(location.search) && window.opener && !CMS.isPreview()) {
    window.addEventListener('message', function (ev) {
      var d = ev.data;
      if (ADMIN_ORIGINS.indexOf(ev.origin) < 0 || !d || d.type !== 'lyd-preview' || !d.data || typeof d.data !== 'object' || !Array.isArray(d.media)) return;
      try {
        sessionStorage.setItem(KEY, JSON.stringify(d.data));
        sessionStorage.setItem(MEDIA_KEY, JSON.stringify(d.media));
        sessionStorage.setItem(PREVIEW_KEY, '1');
      } catch (e) { return; }
      location.reload();
    });
    try { window.opener.postMessage({ type: 'lyd-preview-ready' }, '*'); } catch (e) {}
  }

  window.CMS = CMS;
})();
