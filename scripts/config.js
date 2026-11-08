/* Fabrique js/config.js à partir des variables d'environnement (Vercel) ou du fichier .env (en local).
   Usage : node scripts/config.js */
const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const envFile = path.join(root, '.env');
if (fs.existsSync(envFile)) {
  fs.readFileSync(envFile, 'utf8').split(/\r?\n/).forEach(line => {
    const m = /^\s*([A-Z0-9_]+)\s*=\s*(.*?)\s*$/.exec(line);
    if (m && process.env[m[1]] === undefined) process.env[m[1]] = m[2].replace(/^(['"])(.*)\1$/, '$2');
  });
}

const url = (process.env.SUPABASE_URL || '').replace(/\/+$/, '');
const key = process.env.SUPABASE_PUBLISHABLE_KEY || '';

function stop(msg) {
  console.error('config.js : ' + msg);
  process.exit(1);
}
if (!url || !key) stop('SUPABASE_URL et SUPABASE_PUBLISHABLE_KEY sont requis (fichier .env en local, variables d\'environnement sur Vercel).');
if (!/^https:\/\/[a-z0-9-]+\.supabase\.co$/.test(url)) stop('SUPABASE_URL doit ressembler à https://xxxx.supabase.co');
// Cette page est publique : la clé secrète donnerait tous les droits sur la base
let role = '';
try { role = JSON.parse(Buffer.from(key.split('.')[1] || '', 'base64url').toString()).role || ''; } catch (e) {}
if (/^sb_secret_/.test(key) || role === 'service_role') stop('cette clé est la clé secrète. Mettez la clé « publishable » (ou « anon public »).');
if (!/^sb_publishable_/.test(key) && role !== 'anon') stop('clé inattendue : mettez la clé « publishable » (sb_publishable_…) ou « anon public ».');

const out = '/* Fichier généré par scripts/config.js : ne pas modifier, ne pas enregistrer dans Git. */\n' +
  'window.LYD_SUPABASE = ' + JSON.stringify({ url: url, key: key }) + ';\n';
fs.writeFileSync(path.join(root, 'js', 'config.js'), out);
// Numéro de mise en ligne : un nouveau numéro renouvelle le cache hors ligne des visiteurs (sw.js)
const build = (process.env.VERCEL_GIT_COMMIT_SHA || Date.now().toString(36)).slice(0, 12);
fs.writeFileSync(path.join(root, 'sw-version.js'), '/* Généré par scripts/config.js */\nself.LYD_BUILD = ' + JSON.stringify(build) + ';\n');
console.log('js/config.js écrit pour ' + url);
