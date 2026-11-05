(function () {
  var CONF = window.LYD_SUPABASE || {};
  var BASE = String(CONF.url || '').replace(/\/+$/, '');
  var KEY = CONF.key || '';
  var SESSION = 'lyd_sb_session';
  var refreshing = null;

  
  function readSession() {
    try {
      var raw = sessionStorage.getItem(SESSION) || localStorage.getItem(SESSION);
      return raw ? JSON.parse(raw) : null;
    } catch (e) { return null; }
  }
  function writeSession(s, remember) {
    if (remember === undefined) { var old = readSession(); remember = !!(old && old.remember); }
    var data = {
      access_token: s.access_token, refresh_token: s.refresh_token,
      expires_at: s.expires_at || Math.floor(Date.now() / 1000) + (s.expires_in || 3600),
      user: s.user || null, remember: !!remember
    };
    try {
      sessionStorage.removeItem(SESSION); localStorage.removeItem(SESSION);
      (remember ? localStorage : sessionStorage).setItem(SESSION, JSON.stringify(data));
    } catch (e) {}
    return data;
  }
  function clearSession() {
    try { sessionStorage.removeItem(SESSION); localStorage.removeItem(SESSION); } catch (e) {}
  }
 
  var MESSAGES = {
    invalid_credentials: 'Email ou mot de passe incorrect.',
    email_not_confirmed: "Adresse email pas encore confirmée : ouvrez le lien reçu par email, puis reconnectez-vous.",
    user_already_exists: 'Un compte existe déjà avec cette adresse email.',
    email_exists: 'Un compte existe déjà avec cette adresse email.',
    weak_password: 'Mot de passe trop faible : choisissez-en un plus long.',
    same_password: "Le nouveau mot de passe doit être différent de l'ancien.",
    over_email_send_rate_limit: "Trop d'emails envoyés : réessayez dans une heure.",
    over_request_rate_limit: 'Trop de tentatives : réessayez dans quelques minutes.',
    signup_disabled: 'La création de compte est fermée.',
    email_address_invalid: "Cette adresse email n'est pas acceptée.",
    session_not_found: 'Votre session a expiré : reconnectez-vous.',
    refresh_token_not_found: 'Votre session a expiré : reconnectez-vous.',
    otp_expired: 'Ce lien a expiré ou a déjà servi : demandez-en un nouveau.'
  };
  function failure(status, body) {
    var b = body || {}, code = b.error_code || b.code || b.error || '';
    var text = MESSAGES[code] || '';
    if (!text && /invalid login credentials/i.test(b.msg || b.error_description || '')) text = MESSAGES.invalid_credentials;
    if (!text && code === '42501') text = "Action refusée : votre compte n'a pas les droits nécessaires.";
    if (!text && code === '23505') text = 'Cet élément existe déjà.';
    if (!text && status === 429) text = MESSAGES.over_request_rate_limit;
    if (!text) text = b.message || b.msg || b.error_description || ('Erreur de la base (' + status + ').');
    var err = new Error(text);
    err.status = status;
    err.code = String(code);
    return err;
  }

  /* ---------- Appels ---------- */
  function call(method, path, body, o) {
    o = o || {};
    if (!BASE || !KEY) {
      var missing = new Error('Base de données non configurée : js/config.js est absent (voir .env.example).');
      missing.status = 0;
      missing.code = 'config';
      return Promise.reject(missing);
    }
    var t = o.anon ? Promise.resolve(null) : token();
    return t.then(function (tok) {
      var headers = { apikey: KEY, Accept: 'application/json' };
      if (body !== undefined) headers['Content-Type'] = 'application/json';
      if (tok) headers.Authorization = 'Bearer ' + tok;
      if (o.prefer) headers.Prefer = o.prefer;
      return fetch(BASE + path, { method: method, headers: headers, body: body === undefined ? undefined : JSON.stringify(body) }).catch(function () {
        var err = new Error('Connexion à la base impossible : vérifiez la connexion internet, puis réessayez.');
        err.status = 0;
        err.code = 'network';
        throw err;
      });
    }).then(function (r) {
      return r.text().then(function (txt) {
        var j = null;
        try { j = txt ? JSON.parse(txt) : null; } catch (e) {}
        if (!r.ok) throw failure(r.status, j);
        return j;
      });
    });
  }
  /* Jeton de l'équipe, renouvelé une minute avant expiration ; null pour un visiteur */
  function token() {
    var s = readSession();
    if (!s || !s.access_token) return Promise.resolve(null);
    if (s.expires_at * 1000 - 60000 > Date.now()) return Promise.resolve(s.access_token);
    if (!refreshing) {
      refreshing = call('POST', '/auth/v1/token?grant_type=refresh_token', { refresh_token: s.refresh_token }, { anon: true }).then(function (n) {
        refreshing = null;
        return writeSession(n).access_token;
      }, function (e) {
        refreshing = null;
        if (e.status && e.status < 500) clearSession();
        throw e;
      });
    }
    return refreshing;
  }
  function q(v) { return '"' + String(v).replace(/"/g, '""') + '"'; }
  function back(path) { return encodeURIComponent(location.href.split('#')[0].split('?')[0].replace(/[^/]*$/, '') + (path || 'index.html')); }

  var DB = {
    url: BASE,
    session: readSession,
    token: token,

    signUp: function (email, password, name) {
      return call('POST', '/auth/v1/signup?redirect_to=' + back('index.html'), { email: email, password: password, data: { display_name: name } }, { anon: true }).then(function (r) {
        if (r && r.access_token) { writeSession(r, false); return { session: true, user: r.user }; }
        return { session: false, user: r && (r.user || r) };
      });
    },
    signIn: function (email, password, remember) {
      return call('POST', '/auth/v1/token?grant_type=password', { email: email, password: password }, { anon: true }).then(function (r) {
        return writeSession(r, !!remember);
      });
    },
    signOut: function () {
      var had = readSession();
      var done = had ? call('POST', '/auth/v1/logout', {}).catch(function () {}) : Promise.resolve();
      return done.then(clearSession, clearSession);
    },
    forget: clearSession,
    recover: function (email) {
      return call('POST', '/auth/v1/recover?redirect_to=' + back('index.html'), { email: email }, { anon: true });
    },
    user: function () {
      var s = readSession();
      if (s && s.user && s.user.id) return Promise.resolve(s.user);
      return call('GET', '/auth/v1/user').then(function (u) {
        var cur = readSession();
        if (cur) { cur.user = u; writeSession(cur); }
        return u;
      });
    },
    updateUser: function (patch) {
      return call('PUT', '/auth/v1/user', patch).then(function (u) {
        var s = readSession(); 
        if (s) { s.user = u; writeSession(s); }
        return u;
      });
    },

    fromLink: function () {
      var hash = location.hash.replace(/^#/, '');
      if (!/(^|&)(access_token|error)=/.test(hash)) return null;
      var p = new URLSearchParams(hash);
      history.replaceState(null, '', location.pathname + location.search);
      if (p.get('error')) return { error: MESSAGES[p.get('error_code')] || p.get('error_description') || 'Ce lien ne fonctionne pas.' };
      writeSession({ access_token: p.get('access_token'), refresh_token: p.get('refresh_token'), expires_at: +p.get('expires_at') || 0, expires_in: +p.get('expires_in') || 3600 }, false);
      return { type: p.get('type') || '' };
    },
    
    select: function (table, query, o) { return call('GET', '/rest/v1/' + table + '?' + (query || 'select=*'), undefined, o); },
    insert: function (table, rows, o) {
      o = o || {};
      return call('POST', '/rest/v1/' + table + (o.query ? '?' + o.query : ''), rows, { anon: o.anon, prefer: o.returning ? 'return=representation' : 'return=minimal' });
    },
    upsert: function (table, rows, onConflict) {
      return call('POST', '/rest/v1/' + table + '?on_conflict=' + encodeURIComponent(onConflict), rows, { prefer: 'resolution=merge-duplicates,return=minimal' });
    },
    update: function (table, filter, patch) { return call('PATCH', '/rest/v1/' + table + '?' + filter, patch, { prefer: 'return=minimal' }); },
    remove: function (table, filter) { return call('DELETE', '/rest/v1/' + table + '?' + filter, undefined, { prefer: 'return=minimal' }); },
    inList: function (values) { return 'in.(' + values.map(function (v) { return encodeURIComponent(q(v)); }).join(',') + ')'; },
    eq: function (v) { return 'eq.' + encodeURIComponent(v); }
  };

  window.DB = DB;
})();
 