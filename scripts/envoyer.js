/* Envoi à la main sur le serveur Afrique.host (StackCP), depuis cet ordinateur.
   Usage : npm run envoyer         → construit le site (dist/) puis l'envoie dans public_html/
           npm run envoyer:admin   → envoie le dossier admin/ dans admin.liveydream.com/
   Besoin : la clé SSH ~/.ssh/liveydream_stackcp, autorisée dans StackCP > Accès SSH
            (autre emplacement : DEPLOY_SSH_KEY_PATH dans .env) ; tar et ssh, fournis avec Windows 10 et 11.
   Sur le serveur, les fichiers arrivent dans un dossier temporaire, puis rsync met à jour le dossier en ligne :
   fichiers disparus retirés ; .well-known (certificat https) et cgi-bin jamais touchés. */
const { spawn, execFileSync } = require('child_process');
const fs = require('fs');
const os = require('os');
const path = require('path');

const root = path.join(__dirname, '..');
const envFile = path.join(root, '.env');
if (fs.existsSync(envFile)) {
  fs.readFileSync(envFile, 'utf8').split(/\r?\n/).forEach(line => {
    const m = /^\s*([A-Z0-9_]+)\s*=\s*(.*?)\s*$/.exec(line);
    if (m && process.env[m[1]] === undefined) process.env[m[1]] = m[2].replace(/^(['"])(.*)\1$/, '$2');
  });
}

const SERVER = 'liveydream.com@ssh.us.stackcp.com';
const KEY = process.env.DEPLOY_SSH_KEY_PATH || path.join(os.homedir(), '.ssh', 'liveydream_stackcp');
const admin = process.argv[2] === 'admin';
const from = path.join(root, admin ? 'admin' : 'dist');
const target = admin ? 'admin.liveydream.com' : 'public_html';
const tmp = admin ? '.envoi-admin' : '.envoi-site';
const win = process.platform === 'win32';
const TAR = win && fs.existsSync('C:\\Windows\\System32\\tar.exe') ? 'C:\\Windows\\System32\\tar.exe' : 'tar';
const SSH = win && fs.existsSync('C:\\Windows\\System32\\OpenSSH\\ssh.exe') ? 'C:\\Windows\\System32\\OpenSSH\\ssh.exe' : 'ssh';

function stop(msg) { console.error('envoyer : ' + msg); process.exit(1); }

if (!fs.existsSync(KEY)) stop('clé SSH introuvable (' + KEY + ').');
if (!admin) {
  console.log('1/2 Construction du site…');
  for (const s of ['config.js', 'build.js']) execFileSync(process.execPath, [path.join(__dirname, s)], { stdio: 'inherit', cwd: root });
}
for (const f of admin ? ['index.html', 'js/boot.js', '.htaccess'] : ['index.html', '.htaccess', 'js/config.js']) {
  if (!fs.existsSync(path.join(from, f))) stop(f + ' absent de ' + from + ' : envoi annulé.');
}

console.log((admin ? '' : '2/2 ') + 'Envoi vers ' + target + '/ …');
const remote = [
  'set -eo pipefail', 'umask 022',
  'rm -rf ~/' + tmp, 'mkdir -p ~/' + tmp,
  'tar -xzf - -C ~/' + tmp + ' --warning=no-unknown-keyword',
  'rsync -rlc --delete --delay-updates --exclude /.well-known/ --exclude /cgi-bin/ --stats ~/' + tmp + '/ ~/' + target + '/' +
    ' | grep -E "^Number of (regular files transferred|deleted files)"',
  'rm -rf ~/' + tmp
].join('; ');
const tar = spawn(TAR, ['-czf', '-', '--exclude', './.git', '--exclude', './.github', '--exclude', './.gitignore', '-C', from, '.'], { stdio: ['ignore', 'pipe', 'inherit'] });
const ssh = spawn(SSH, ['-i', KEY, '-o', 'IdentitiesOnly=yes', '-o', 'BatchMode=yes', SERVER, remote], { stdio: ['pipe', 'inherit', 'inherit'] });
tar.stdout.pipe(ssh.stdin);
let tarCode = null;
tar.on('close', code => { tarCode = code; });
ssh.on('close', code => {
  if (tarCode) stop('archive impossible (tar, code ' + tarCode + ').');
  if (code) stop('envoi échoué (ssh, code ' + code + '). Rien n\'a été remplacé si l\'erreur est survenue avant rsync.');
  console.log('Envoyé : https://' + (admin ? 'admin.liveydream.com' : 'liveydream.com') + '/');
});
