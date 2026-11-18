/* Fabrique dist/.htaccess (serveur Apache d'Afrique.host) à partir de vercel.json :
   mêmes redirections, mêmes réécritures, mêmes en-têtes que sur Vercel.
   vercel.json reste la seule liste de redirections à tenir à jour. Appelé par scripts/build.js. */

const HOST = 'liveydream.com';
/* Adresses de l'administration : elles seules peuvent lire les pages du site depuis le navigateur (réglages SEO de l'admin) */
const ADMIN_ORIGINS = ['https://central.liveydream.com', 'https://admin.liveydream.com', 'https://liveydream-admin.vercel.app'];

const esc = s => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

/* /blog/:slug, /:path+/index.html… → motif Apache (sans la barre du début) et noms des variables */
function pattern(source) {
  const names = [];
  const re = source.replace(/^\//, '').split(/(:[a-zA-Z_]\w*[+*]?)/).map((part, i) => {
    if (i % 2 === 0) {
      if (/[()*?\\\s]/.test(part)) throw new Error('vercel.json : motif non pris en charge « ' + source + ' »');
      return esc(part);
    }
    const m = /^:(\w+)([+*]?)$/.exec(part);
    names.push(m[1]);
    return m[2] === '+' ? '(.+)' : m[2] === '*' ? '(.*)' : '([^/]+)';
  }).join('');
  return { re: '^' + re + '$', names };
}

function target(dest, names, source) {
  if (/\s/.test(dest)) throw new Error('vercel.json : destination non prise en charge « ' + dest + ' »');
  return dest.replace(/:(\w+)[+*]?/g, (all, n, at) => {
    if (dest.slice(at, at + 3) === '://') return all;
    const i = names.indexOf(n);
    if (i < 0) throw new Error('vercel.json : « :' + n + ' » absent de « ' + source + ' »');
    return '$' + (i + 1);
  });
}

function plain(r) {
  if (r.has || r.missing) throw new Error('vercel.json : condition has/missing non prise en charge (' + r.source + ')');
}

module.exports = function htaccess(vercel) {
  const out = [
    '# Généré par scripts/build.js à partir de vercel.json : ne pas modifier ici, modifier vercel.json.',
    'Options -Indexes',
    'DirectoryIndex index.html',
    'AddDefaultCharset utf-8',
    'AddType image/webp .webp',
    '',
    'RewriteEngine On',
    '# Page déjà réécrite ou redirigée en interne : servie telle quelle (évite les boucles)',
    'RewriteCond %{ENV:REDIRECT_STATUS} .',
    'RewriteRule ^ - [L]',
    '',
    '# Toujours en https',
    'RewriteCond %{HTTPS} !=on',
    'RewriteCond %{HTTP:X-Forwarded-Proto} !=https',
    'RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L,NE]',
    '# www.' + HOST + ' → ' + HOST,
    'RewriteCond %{HTTP_HOST} ^www\\.' + esc(HOST) + '$ [NC]',
    'RewriteRule ^ https://' + HOST + '%{REQUEST_URI} [R=301,L,NE]',
    '',
    '# Redirections (anciennes adresses du site WordPress)'
  ];

  (vercel.redirects || []).forEach(r => {
    plain(r);
    const p = pattern(r.source);
    const code = r.statusCode || (r.permanent === false ? 307 : 308);
    /* …/index.html : seulement si le visiteur l'a demandé lui-même (pas la page d'accueil d'un dossier servie par Apache) */
    if (/index\\\.html\$$/.test(p.re)) out.push('RewriteCond %{THE_REQUEST} \\s/[^?\\s]*/index\\.html[?\\s]');
    /* Adresse complète en https : sinon Apache, derrière le relais d'Afrique.host, pourrait renvoyer vers http:// (un détour de plus) */
    const to = target(r.destination, p.names, r.source);
    out.push('RewriteRule ' + p.re + ' ' + (to[0] === '/' ? 'https://%{HTTP_HOST}' : '') + to + ' [R=' + code + ',L,NE,NS]');
  });
  out.push('# Dossier demandé sans la barre finale (/blog/article) : même chose, directement en https',
    'RewriteCond %{REQUEST_FILENAME} -d',
    'RewriteRule ^(.*[^/])$ https://%{HTTP_HOST}/$1/ [R=301,L,NE]');

  out.push('', '# Réécritures : l\'adresse reste, la page servie change (seulement si aucun fichier ne correspond)');
  (vercel.rewrites || []).forEach(r => {
    plain(r);
    const p = pattern(r.source);
    out.push('RewriteCond %{REQUEST_FILENAME} !-f', 'RewriteCond %{REQUEST_FILENAME} !-d',
      'RewriteRule ' + p.re + ' ' + target(r.destination, p.names, r.source) + ' [L]');
  });

  out.push(
    '',
    '<IfModule mod_headers.c>',
    '  # L\'administration peut lire les pages du site (réglages SEO)',
    '  SetEnvIf Origin "^(' + ADMIN_ORIGINS.map(esc).join('|') + ')$" LYD_ADMIN=$0',
    '  Header always set Access-Control-Allow-Origin "%{LYD_ADMIN}e" env=LYD_ADMIN',
    '  Header always merge Vary Origin',
    '  # Toute autre adresse que ' + HOST + ' (adresse de test) : cachée à Google',
    '  SetEnvIfNoCase Host "^' + esc(HOST) + '(:[0-9]+)?$" LYD_PROD',
    '  Header always set X-Robots-Tag "noindex, nofollow" env=!LYD_PROD',
    '  # Comme Vercel : le navigateur vérifie à chaque visite si le fichier a changé',
    '  Header set Cache-Control "public, max-age=0, must-revalidate"',
    '  <FilesMatch "^(sw|sw-version)\\.js$">',
    '    Header set Cache-Control "no-cache"',
    '  </FilesMatch>',
    '  <If "%{REQUEST_URI} =~ m#^/media/#">',
    '    Header set Cache-Control "public, max-age=31536000, immutable"',
    '  </If>',
    '</IfModule>',
    '',
    '<IfModule mod_deflate.c>',
    '  AddOutputFilterByType DEFLATE text/html text/css text/plain text/xml application/xml application/json application/javascript text/javascript image/svg+xml',
    '</IfModule>',
    ''
  );
  return out.join('\n');
};
