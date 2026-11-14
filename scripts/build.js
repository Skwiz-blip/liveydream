/* Fabrique le site prêt à mettre en ligne dans dist/ :
   - chaque page avec son contenu déjà écrit dans le HTML (Google et les assistants IA le lisent sans JavaScript) ;
   - une page par article (/blog/<adresse>/) et par offre d'emploi (/carrieres/<adresse>/) ;
   - les images de la Médiathèque en vrais fichiers (dist/media/) au lieu de texte dans les pages ;
   - adresse de référence, aperçu pour les réseaux sociaux, fiche d'identité pour Google (JSON-LD) ;
   - sitemap.xml et robots.txt.
   Une fois la page ouverte, le JavaScript la remet à jour comme avant.
   Usage : node scripts/config.js && node scripts/build.js   (adresse du site : variable SITE_URL)
   Si la base ne répond pas, les pages sont copiées telles quelles : le site marche, Google voit moins de contenu. */
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { JSDOM, ResourceLoader, VirtualConsole } = require('jsdom');

const root = path.join(__dirname, '..');
const out = path.join(root, 'dist');
/* Adresse publique du site (adresses de référence, sitemap, aperçus) ; le site de test liveydream.vercel.app reste caché à Google (vercel.json) */
const SITE = (process.env.SITE_URL || 'https://liveydream.com').replace(/\/+$/, '');
const NAME = 'Live Y Dream';
const PAGES = ['index.html', 'services.html', 'campagnes.html', 'blog.html', 'a-propos.html', 'carrieres.html', 'contact.html', 'mentions-legales.html', 'confidentialite.html'];
/* Jamais mis en ligne : outils, base, documents de travail, secrets */
const SKIP = new Set(['.git', '.github', '.dist', '.gitignore', '.vercelignore', '.vscode', '.claude', 'admin', 'database', 'dist', 'node_modules', 'ref', 'scripts', 'package.json', 'package-lock.json', 'vercel.json']);
const skipFile = name => SKIP.has(name) || /\.(docx?|md)$/i.test(name) || /^\.env/.test(name);

function copyDir(from, to) {
  fs.mkdirSync(to, { recursive: true });
  for (const e of fs.readdirSync(from, { withFileTypes: true })) {
    if (skipFile(e.name)) continue;
    const a = path.join(from, e.name), b = path.join(to, e.name);
    if (e.isDirectory()) copyDir(a, b); else fs.copyFileSync(a, b);
  }
}
const write = (rel, text) => {
  const f = path.join(out, rel);
  fs.mkdirSync(path.dirname(f), { recursive: true });
  fs.writeFileSync(f, text);
};
const slugify = s => String(s || '').toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
/* Même règle que CMS.svcAnchor (js/cms.js) : ancre propre du service, sinon s1, s2… */
const svcAnchor = (x, i) => (x && x.slug && slugify(x.slug)) || 's' + (i + 1);
const articleSlug = id => /^[a-z0-9]+(-[a-z0-9]+)*$/.test(String(id || '')) ? String(id) : slugify(id);
const published = list => (Array.isArray(list) ? list : []).filter(x => x && x.status !== 'brouillon');
const xml = s => String(s).replace(/[<>&'"]/g, c => ({ '<': '&lt;', '>': '&gt;', '&': '&amp;', "'": '&apos;', '"': '&quot;' }[c]));

/* Lit le contenu publié une seule fois, avec la même clé publique que les visiteurs */
async function readContent() {
  const conf = fs.readFileSync(path.join(root, 'js', 'config.js'), 'utf8');
  const m = /window\.LYD_SUPABASE = (\{.*\});/.exec(conf);
  if (!m) throw new Error('js/config.js illisible : lancez d\'abord node scripts/config.js');
  const { url, key } = JSON.parse(m[1]);
  const r = await fetch(url + '/rest/v1/site_content?select=key,value&is_public=eq.true', {
    headers: { apikey: key, Accept: 'application/json' }, signal: AbortSignal.timeout(30000)
  });
  if (!r.ok) throw new Error('la base répond ' + r.status);
  const rows = await r.json();
  if (!Array.isArray(rows) || !rows.length) throw new Error('aucun contenu publié dans site_content');
  const data = {};
  rows.forEach(x => { data[x.key] = x.value; });
  return { url, rows, data };
}

/* Images de la Médiathèque (texte base64 dans la base) → fichiers dist/media/<id>-<empreinte>.<ext>.
   Le nom change si l'image change : les navigateurs peuvent la garder longtemps. */
const EXT = { 'image/webp': 'webp', 'image/png': 'png', 'image/jpeg': 'jpg', 'image/jpg': 'jpg', 'image/gif': 'gif', 'image/avif': 'avif', 'image/svg+xml': 'svg' };
function writeMedia(media) {
  const files = {};
  Object.keys(media || {}).forEach(id => {
    const src = String((media[id] || {}).src || '');
    const m = /^data:(image\/[a-z0-9.+-]+);base64,(.*)$/i.exec(src);
    if (!m || !EXT[m[1].toLowerCase()] || !/^[\w-]+$/.test(id)) return;
    const bytes = Buffer.from(m[2], 'base64');
    const f = 'media/' + id + '-' + crypto.createHash('sha1').update(bytes).digest('hex').slice(0, 8) + '.' + EXT[m[1].toLowerCase()];
    write(f, bytes);
    files[id] = { f: f, n: src.length };
  });
  return files;
}

/* Les scripts de la page sont lus dans dist/ ; images et styles ne servent pas ici */
class LocalFiles extends ResourceLoader {
  fetch(url) {
    const u = new URL(url);
    if (u.origin !== SITE || !/\.js$/.test(u.pathname)) return null;
    const f = path.join(out, decodeURIComponent(u.pathname));
    return f.startsWith(out) && fs.existsSync(f) ? Promise.resolve(fs.readFileSync(f)) : null;
  }
}

/* ---------- Fiche d'identité pour Google (schema.org) ---------- */
const DAYS = { lundi: 'Monday', mardi: 'Tuesday', mercredi: 'Wednesday', jeudi: 'Thursday', vendredi: 'Friday', samedi: 'Saturday', dimanche: 'Sunday' };
const ORDER = Object.keys(DAYS);
function hoursSpec(hours) {
  const time = t => { const m = /^(\d{1,2})\s*h\s*(\d{2})?$/i.exec(t.trim()); return m ? m[1].padStart(2, '0') + ':' + (m[2] || '00') : null; };
  return (hours || []).map(h => {
    const days = String(h[0] || '').toLowerCase().normalize('NFC').split(/\s*[-–]\s*/).map(d => d.trim());
    const times = String(h[1] || '').split(/\s*[-–]\s*/);
    if (!DAYS[days[0]] || times.length !== 2) return null;
    const from = ORDER.indexOf(days[0]), to = days[1] ? ORDER.indexOf(days[1]) : from;
    const opens = time(times[0]), closes = time(times[1]);
    if (to < from || !opens || !closes) return null;
    return { '@type': 'OpeningHoursSpecification', dayOfWeek: ORDER.slice(from, to + 1).map(d => DAYS[d]), opens, closes };
  }).filter(Boolean);
}
const cleanLink = u => { try { const x = new URL(u); return x.origin + x.pathname.replace(/\/+$/, ''); } catch (e) { return null; } };
function business(data, image) {
  const s = data.settings || {}, c = data.contact || {};
  const o = {
    '@context': 'https://schema.org', '@type': 'LocalBusiness', '@id': SITE + '/#agence',
    name: NAME, url: SITE + '/', description: s.baseline || undefined, image: image || undefined, logo: SITE + '/images/logo-lyd-noir.png',
    telephone: s.phone || undefined, email: s.email || undefined, foundingDate: '2013', priceRange: 'FCFA',
    address: { '@type': 'PostalAddress', streetAddress: (c.address || [])[0] || undefined, addressLocality: 'Lomé', addressCountry: 'TG' },
    openingHoursSpecification: hoursSpec(c.hours),
    sameAs: (c.socials || []).map(x => cleanLink(x[1])).filter(Boolean)
  };
  if (!o.openingHoursSpecification.length) delete o.openingHoursSpecification;
  /* Catalogue des services (repris de Réglages > Services) : Google peut les afficher sous la fiche de l'agence.
     Nom court et « Description pour Google » du service s'ils sont remplis. */
  const all = Array.isArray(data.services) ? data.services : [];
  const svcs = all.map((x, i) => [x, i]).filter(([x]) => x && x.t);
  if (svcs.length) o.hasOfferCatalog = {
    '@type': 'OfferCatalog', name: 'Services de communication',
    itemListElement: svcs.map(([x, i]) => ({ '@type': 'Offer', itemOffered: { '@type': 'Service', name: x.cat || x.t, description: x.ld || x.d || x.long || undefined, url: SITE + '/services.html#' + svcAnchor(x, i) } }))
  };
  return o;
}
const org = () => ({ '@type': 'Organization', '@id': SITE + '/#agence', name: NAME, url: SITE + '/', logo: SITE + '/images/logo-lyd-noir.png' });
function crumbs(items) {
  return { '@context': 'https://schema.org', '@type': 'BreadcrumbList', itemListElement: items.map((x, i) => ({ '@type': 'ListItem', position: i + 1, name: x[0], item: x[1] })) };
}
const JOB_TYPES = [[/cdi|temps plein|full/i, 'FULL_TIME'], [/cdd|temporaire/i, 'TEMPORARY'], [/stage|stagiaire|alternance/i, 'INTERN'], [/freelance|prestataire|indépendant/i, 'CONTRACTOR'], [/temps partiel|mi-temps/i, 'PART_TIME']];

/* ---------- Construction d'une page ---------- */
async function render(page, content, files) {
  const problems = [];
  const vc = new VirtualConsole();
  vc.on('error', (...a) => { const t = a.join(' '); if (/\[LYD\]/.test(t)) problems.push(t); });
  vc.on('jsdomError', e => { if (!/Not implemented/.test(e.message)) problems.push(e.message); });
  /* <base href="/"> : les pages dans un sous-dossier (/blog/<adresse>/) trouvent styles, scripts et liens à la racine */
  const html = fs.readFileSync(path.join(root, page.tpl), 'utf8').replace(/<meta charset="utf-8">/i,
    m => m + '\n<base href="/" data-lyd-built>\n<link rel="canonical" href="' + xml(page.url) + '">');
  const dom = new JSDOM(html, {
    url: page.url,
    runScripts: 'dangerously',
    resources: new LocalFiles(),
    pretendToBeVisual: true,
    virtualConsole: vc,
    beforeParse(w) {
      w.LYD_NO_CACHE = true; // ni copie locale, ni préchargement, ni service worker pendant la construction
      w.LYD_MEDIA = files;
      w.fetch = (u) => {
        const ok = String(u).startsWith(content.url + '/rest/v1/site_content');
        const body = ok ? JSON.stringify(content.rows) : '[]';
        return Promise.resolve({ ok: true, status: 200, text: () => Promise.resolve(body) });
      };
    }
  });
  const w = dom.window, d = w.document;
  try {
    const t0 = Date.now();
    while (!(w.LYD_WAIT === false && d.querySelector('header.hd'))) {
      if (problems.length) throw new Error(problems[0]);
      if (Date.now() - t0 > 15000) throw new Error('la page ne s\'est pas construite en 15 secondes');
      await new Promise(r => setTimeout(r, 25));
    }
    await new Promise(r => setTimeout(r, 100));
    if (problems.length) throw new Error(problems[0]);
    if (page.check && !page.check(d)) throw new Error('contenu attendu absent');
    /* Éléments ajoutés par le navigateur du visiteur : il les recrée lui-même */
    d.querySelectorAll('#toTop, #lyd-err, #lyd-pv').forEach(el => el.remove());
    /* Page d'un article : la liste du blog, cachée, n'a pas à être lue par Google (le JavaScript la remplit au besoin) */
    if (page.kind === 'article') {
      ['feat', 'grid', 'pager', 'cats', 'cats2', 'tags'].forEach(id => { const el = d.getElementById(id); if (el) el.innerHTML = ''; });
      d.querySelectorAll('#blog-content .phero').forEach(el => el.remove()); // un seul titre principal : celui de l'article
    }
    head(d, page, w.CMS);
    /* Liens écrits depuis la racine (/carrieres.html) : certains robots, comme l'analyse de Bing, ignorent <base href="/">
       et cherchaient /blog/<article>/carrieres.html, qui n'existe pas */
    d.querySelectorAll('[href],[src]').forEach(el => {
      if (el.tagName === 'BASE') return;
      ['href', 'src'].forEach(at => {
        const v = el.getAttribute(at);
        if (v && !/^([a-z][a-z0-9+.-]*:|[/#?])/i.test(v)) el.setAttribute(at, v === 'index.html' ? '/' : v.indexOf('index.html#') === 0 ? '/' + v.slice(10) : '/' + v);
      });
    });
    const main = d.querySelector('main');
    return { html: '<!doctype html>\n' + d.documentElement.outerHTML + '\n', words: main ? main.textContent.replace(/\s+/g, ' ').trim().split(' ').length : 0 };
  } finally {
    w.close();
  }
}

/* Balises lues par Google, Facebook, WhatsApp, LinkedIn… */
function head(d, page, CMS) {
  const abs = u => { if (!u || /^data:/i.test(u)) return ''; try { return new URL(u, SITE + '/').href; } catch (e) { return ''; } };
  const meta = (attr, name, value) => {
    if (!value) return;
    let el = d.head.querySelector('meta[' + attr + '="' + name + '"]');
    if (!el) { el = d.createElement('meta'); el.setAttribute(attr, name); d.head.appendChild(el); }
    el.setAttribute('content', value);
  };
  const desc = (d.querySelector('meta[name="description"]') || {}).content || '';
  const image = abs(CMS.src(page.image || (CMS.get('settings').hero || {}).image));
  meta('property', 'og:type', page.kind === 'article' ? 'article' : 'website');
  meta('property', 'og:site_name', NAME);
  meta('property', 'og:locale', 'fr_FR');
  meta('property', 'og:title', d.title);
  meta('property', 'og:description', desc);
  meta('property', 'og:url', page.url);
  meta('property', 'og:image', image);
  meta('name', 'twitter:card', image ? 'summary_large_image' : 'summary');
  meta('name', 'twitter:title', d.title);
  meta('name', 'twitter:description', desc);
  meta('name', 'twitter:image', image);
  const ld = (page.ld ? page.ld(image) : []).filter(Boolean);
  ld.forEach(obj => {
    const s = d.createElement('script');
    s.type = 'application/ld+json';
    s.textContent = JSON.stringify(obj).replace(/</g, '\\u003c');
    d.head.appendChild(s);
  });
}

/* ---------- Liste des pages à fabriquer ---------- */
function plan(data) {
  const s = data.settings || {}, c = data.contact || {};
  const home = SITE + '/';
  const list = PAGES.map(p => ({
    tpl: p, out: p, url: p === 'index.html' ? home : SITE + '/' + p,
    ld: p === 'index.html' || p === 'contact.html' ? img => [business(data, img)] : null
  }));
  published(data.articles).forEach(a => {
    const slug = articleSlug(a.id), url = SITE + '/blog/' + slug + '/';
    if (!slug) return;
    list.push({
      tpl: 'blog.html', out: 'blog/' + slug + '/index.html', url, kind: 'article', image: a.img, lastmod: a.dateISO || '',
      check: d => !!d.querySelector('#article-view h1') && d.querySelector('#article-view h1').textContent === a.t,
      ld: img => [{
        '@context': 'https://schema.org', '@type': 'BlogPosting', headline: String(a.t).slice(0, 110),
        description: a.seoD || a.ex || undefined, image: img || undefined, inLanguage: 'fr',
        datePublished: a.dateISO || undefined, dateModified: a.updatedAt ? new Date(a.updatedAt).toISOString() : (a.dateISO || undefined),
        author: org(), publisher: org(),
        mainEntityOfPage: url, keywords: (a.tags || []).join(', ') || undefined
      }, crumbs([['Accueil', home], ['Blog', SITE + '/blog.html'], [a.t, url]])]
    });
  });
  /* Pages métiers : une adresse courte à la racine, /agence-evenementielle-lome/ */
  const svcs = Array.isArray(data.services) ? data.services : [];
  published(data.metiers).filter(m => m && m.id && m.h1).forEach(m => {
    const slug = slugify(m.id), url = SITE + '/' + slug + '/';
    if (!slug || PAGES.includes(slug) || ['blog', 'carrieres', 'media', 'images', 'css', 'js', 'fonts'].includes(slug)) return;
    const svc = svcs.find(x => x.t === m.svc) || {};
    const faq = (m.faq || []).filter(x => x && x.q && x.a);
    list.push({
      tpl: 'metier.html', out: slug + '/index.html', url, kind: 'metier', image: m.img || svc.img, lastmod: '',
      check: d => !!d.querySelector('#m-h1') && d.querySelector('#m-h1').textContent === m.h1,
      ld: img => [{
        '@context': 'https://schema.org', '@type': 'Service', name: m.h1, serviceType: m.k || svc.cat || undefined,
        description: m.seoD || m.intro || undefined, url, image: img || undefined, provider: org(),
        areaServed: [{ '@type': 'City', name: 'Lomé' }, { '@type': 'Country', name: 'Togo' }],
        offers: (m.price || svc.price) && /\d/.test(m.price || svc.price) ? { '@type': 'Offer', description: [m.price ? m.priceLabel : svc.priceLabel, m.price || svc.price].filter(Boolean).join(' ') } : undefined
      }, faq.length ? {
        '@context': 'https://schema.org', '@type': 'FAQPage',
        mainEntity: faq.map(x => ({ '@type': 'Question', name: x.q, acceptedAnswer: { '@type': 'Answer', text: String(x.a).replace(/\s+/g, ' ').trim() } }))
      } : null, crumbs([['Accueil', home], ['Services', SITE + '/services.html'], [m.k || m.h1, url]])]
    });
  });
  published(data.jobs).forEach(j => {
    const slug = slugify(j.t || j.id), url = SITE + '/carrieres/' + slug + '/';
    if (!slug) return;
    const type = (JOB_TYPES.find(t => t[0].test(j.type || '')) || [])[1];
    const text = [j.d].concat((j.missions || []).map(x => '• ' + x), (j.profil || []).map(x => '• ' + x), (j.avantages || []).map(x => '• ' + x)).filter(Boolean).join('\n');
    list.push({
      tpl: 'carrieres.html', out: 'carrieres/' + slug + '/index.html', url, kind: 'offer', lastmod: j.dateISO || '',
      check: d => !!d.querySelector('.job-d h2'),
      ld: () => [j.dateISO && text ? {
        '@context': 'https://schema.org', '@type': 'JobPosting', title: j.t, description: text, datePosted: j.dateISO,
        employmentType: type, hiringOrganization: { '@type': 'Organization', name: NAME, sameAs: home },
        jobLocation: { '@type': 'Place', address: { '@type': 'PostalAddress', streetAddress: (c.address || [])[0] || undefined, addressLocality: 'Lomé', addressCountry: 'TG' } }
      } : null, crumbs([['Accueil', home], ['Carrières', SITE + '/carrieres.html'], [j.t, url]])]
    });
  });
  return list;
}

function sitemap(pages) {
  const urls = pages.map(p => '  <url><loc>' + xml(p.url) + '</loc>' + (/^\d{4}-\d{2}-\d{2}$/.test(p.lastmod || '') ? '<lastmod>' + p.lastmod + '</lastmod>' : '') + '</url>');
  write('sitemap.xml', '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n' + urls.join('\n') + '\n</urlset>\n');
  write('robots.txt', 'User-agent: *\nAllow: /\n\nSitemap: ' + SITE + '/sitemap.xml\n');
}

(async () => {
  fs.rmSync(out, { recursive: true, force: true });
  copyDir(root, out);
  let content;
  try {
    content = await readContent();
  } catch (e) {
    console.warn('build.js : ATTENTION, contenu non lu (' + e.message + '). Pages copiées sans leur contenu.');
    sitemap(PAGES.map(p => ({ url: p === 'index.html' ? SITE + '/' : SITE + '/' + p })));
    return;
  }
  const files = writeMedia(content.data.media);
  fs.appendFileSync(path.join(out, 'js', 'config.js'), '/* Images enregistrées en fichiers par scripts/build.js */\nwindow.LYD_MEDIA = ' + JSON.stringify(files) + ';\n');
  console.log('  ' + Object.keys(files).length + ' images enregistrées dans media/');
  const pages = plan(content.data), done = [];
  let failed = 0;
  for (const page of pages) {
    try {
      const r = await render(page, content, files);
      write(page.out, r.html);
      done.push(page);
      if (!page.kind) console.log('  ' + page.out + ' : ' + r.words + ' mots, ' + Math.round(r.html.length / 1024) + ' Ko');
    } catch (e) {
      failed++;
      if (!page.kind) fs.copyFileSync(path.join(root, page.tpl), path.join(out, page.out));
      console.warn('  ' + page.out + ' : ATTENTION, ' + (page.kind ? 'page non créée' : 'copiée sans son contenu') + ' (' + e.message + ')');
    }
  }
  const n = k => done.filter(p => p.kind === k).length;
  console.log('  ' + n('metier') + ' pages métiers, ' + n('article') + ' pages d\'articles, ' + n('offer') + ' pages d\'offres');
  sitemap(pages.filter(p => !p.kind || done.indexOf(p) > -1));
  console.log('build.js : dist/ prêt' + (failed ? ', ' + failed + ' problème(s)' : '') + ' (' + SITE + ')');
})().catch(e => { console.error('build.js : ' + e.message); process.exit(1); });
