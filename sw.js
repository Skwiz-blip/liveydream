/* Live Y Dream - cache hors ligne du site public.
   Pages, styles et scripts : gardés sur l'appareil, renouvelés à chaque mise en ligne (numéro dans sw-version.js).
   Images : gardées après leur premier affichage. Base de données et formulaires : jamais mis en cache ici. */
importScripts('sw-version.js');
var BUILD = self.LYD_BUILD || 'dev';
var CORE_CACHE = 'lyd-core-' + BUILD, IMG_CACHE = 'lyd-images', MAX_IMAGES = 150;
var CORE = ['./', 'index.html', 'services.html', 'campagnes.html', 'blog.html', 'a-propos.html', 'carrieres.html', 'contact.html',
  'css/global.css', 'css/pages.css', 'js/config.js', 'js/db.js', 'js/cms.js'];

self.addEventListener('install', function (ev) {
  ev.waitUntil(caches.open(CORE_CACHE).then(function (c) {
    return c.addAll(CORE.map(function (u) { return new Request(u, { cache: 'reload' }); }));
  }).then(function () { return self.skipWaiting(); }));
});

self.addEventListener('activate', function (ev) {
  ev.waitUntil(caches.keys().then(function (keys) {
    return Promise.all(keys.filter(function (k) { return k.indexOf('lyd-core-') === 0 && k !== CORE_CACHE; }).map(function (k) { return caches.delete(k); }));
  }).then(function () { return self.clients.claim(); }));
});

function isImage(req, url) { return req.destination === 'image' || /\.(png|jpe?g|webp|gif|svg|avif)$/i.test(url.pathname); }

function trim(cache) {
  return cache.keys().then(function (keys) {
    return Promise.all(keys.slice(0, Math.max(0, keys.length - MAX_IMAGES)).map(function (k) { return cache.delete(k); }));
  });
}

function imageFirst(req) {
  return caches.open(IMG_CACHE).then(function (cache) {
    return cache.match(req).then(function (hit) {
      if (hit) return hit;
      return fetch(req).then(function (res) {
        if (res && (res.ok || res.type === 'opaque')) cache.put(req, res.clone()).then(function () { return trim(cache); });
        return res;
      });
    });
  });
}

/* Une page avec ?id=… est la même page : elle est retrouvée sans ses paramètres */
function coreFirst(req, url) {
  var key = url.origin + (url.pathname === '/' ? '/' : url.pathname);
  return caches.open(CORE_CACHE).then(function (cache) {
    return cache.match(key).then(function (hit) {
      if (hit) return hit;
      return fetch(req).then(function (res) {
        if (res && res.ok && req.mode === 'navigate') cache.put(key, res.clone());
        return res;
      }, function () { return cache.match(url.origin + '/index.html'); });
    });
  });
}

self.addEventListener('fetch', function (ev) {
  var req = ev.request;
  if (req.method !== 'GET') return;
  var url = new URL(req.url);
  if (url.origin === self.location.origin) {
    if (/\/admin(\/|$)/.test(url.pathname) || /sw(-version)?\.js$/.test(url.pathname)) return;
    if (isImage(req, url)) { ev.respondWith(imageFirst(req)); return; }
    var name = url.pathname.replace(/^\//, '') || './';
    if (req.mode === 'navigate' || CORE.indexOf(name) > -1) ev.respondWith(coreFirst(req, url));
    return;
  }
  if (isImage(req, url)) ev.respondWith(imageFirst(req));
});
