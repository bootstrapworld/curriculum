/*
 * early-login-check.js — the one place this site asks bootstrapworld.org who
 * the current user is (admin-ajax.php?action=get_user_hash), and the one place
 * that decides how often it is worth asking.
 *
 * This must be loaded as a plain, non-deferred, non-async <script src>,
 * placed as close to the very top of <head> as possible -- before every
 * other script -- so the network round-trip to bootstrapworld.org starts
 * immediately, in parallel with everything else the page still has to load
 * (CodeMirror modes, pdf-lib, the dependency graph, etc.), instead of
 * waiting for all of that to finish first.
 *
 * It never touches the DOM, so it's always safe to run before the DOM exists.
 * It exposes:
 *   window.getUserIdentity()   Promise<{status: 'in'|'out'|'unknown', hash?}>
 *   window.__userHashPromise   Promise<hash | undefined>; fetchUserHash() in
 *                              page-render.js returns this
 *
 * WHY THERE IS A CACHE. A logged-in lookup boots WordPress and WooCommerce on
 * a shared host (~0.5 CPU-seconds), and every page load used to make one.
 * Reloads, a burst of tabs (session restore, open-many, ./author reloading or
 * auto-opening several pages after one rebuild) multiplied that. Layers, from
 * cheapest to dearest:
 *
 *   1. memory       the settled result, for the life of the page, and the
 *                   in-flight Promise, so concurrent callers share one request
 *   2. sessionStorage  per tab, so reloads and navigation within a tab reuse
 *                   it: 5 min if logged in, 30 s if logged out (someone may
 *                   log in during the session, and a logged-out lookup is
 *                   already cheap on the server)
 *   3. localStorage "burst" entry, shared by every tab of this origin but
 *                   trusted for only 15 s, plus a Web Lock so tabs loading at
 *                   the same moment make one request between them
 *
 * STALENESS. The login cookie is HttpOnly, so JS can't see a login or logout.
 * A cached identity can therefore be wrong -- on a shared computer, a stale
 * entry could attribute work to the previous teacher. Bounds: 15 s across
 * tabs, 5 min within the tab that last looked. Both are dropped early when
 * (a) a link to my-account / wp-login / logout is clicked, or (b) the page was
 * reached from a bootstrapworld.org page outside /materials/ (i.e. the
 * WordPress site, where logging in and out happens). The page itself keeps
 * whatever identity it started with, exactly as before.
 *
 * FAILURES (network error, non-2xx, a non-JSON body such as a Cloudflare
 * "Just a moment..." page, unexpected JSON) are never cached as an identity.
 * They resolve {status: 'unknown'} -- callers treat that as not logged in, as
 * they always have -- and pause new requests for 30 s, doubling to 5 min, so a
 * struggling server isn't retried on every page load.
 *
 * Wrapped in a factory so lib/test/early-login-check.test.cjs can drive it
 * with fake fetch/storage/clock; in a browser it just runs.
 */
(function (root) {
  function makeIdentity(env) {
    var LOOKUP_URL = 'https://bootstrapworld.org/wp-admin/admin-ajax.php?action=get_user_hash';
    var SESSION_KEY = 'bw.identity.v1';
    var BURST_KEY = 'bw.identity.burst';
    var FAIL_KEY = 'bw.identity.fail';
    var TTL_IN = 5 * 60 * 1000;
    var TTL_OUT = 30 * 1000;
    var BURST_TTL = 15 * 1000;
    var LOCK_WAIT = 3000;
    var BACKOFF_MIN = 30 * 1000;
    var BACKOFF_MAX = 5 * 60 * 1000;

    var memo = null;      // settled identity for this page
    var inflight = null;  // Promise of the lookup in progress

    // sessionStorage / localStorage can throw (disabled, private mode, quota).
    function read(store, key) {
      try {
        var raw = store && store.getItem(key);
        return raw ? JSON.parse(raw) : null;
      } catch (e) { return null; }
    }
    function write(store, key, value) {
      try { if (store) store.setItem(key, JSON.stringify(value)); } catch (e) {}
    }
    function remove(store, key) {
      try { if (store) store.removeItem(key); } catch (e) {}
    }

    function clear() {
      memo = null;
      remove(env.sessionStorage, SESSION_KEY);
      remove(env.localStorage, BURST_KEY);
      remove(env.sessionStorage, FAIL_KEY);
    }

    function usableEntry(entry, ttlIn, ttlOut) {
      if (!entry || (entry.status !== 'in' && entry.status !== 'out')) return null;
      var age = env.now() - entry.t;
      if (age < 0) return null; // clock moved backwards
      var ttl = entry.status === 'in' ? ttlIn : ttlOut;
      if (age >= ttl) return null;
      if (entry.status === 'in' && !entry.hash) return null;
      return entry;
    }

    function toIdentity(entry) {
      return entry.status === 'in' ? { status: 'in', hash: entry.hash } : { status: 'out' };
    }

    // `entry` is a fresh lookup (stamped now) or another tab's burst entry,
    // which keeps ITS timestamp: reusing it must neither extend the shared
    // 15 s window nor make this tab's copy look newer than the lookup was.
    function remember(entry, fromBurst) {
      write(env.sessionStorage, SESSION_KEY, entry);
      if (!fromBurst) write(env.localStorage, BURST_KEY, entry);
      remove(env.sessionStorage, FAIL_KEY);
      return toIdentity(entry);
    }

    function fail() {
      var prior = read(env.sessionStorage, FAIL_KEY);
      var n = (prior && prior.n) ? prior.n + 1 : 1;
      var wait = Math.min(BACKOFF_MIN * Math.pow(2, n - 1), BACKOFF_MAX);
      write(env.sessionStorage, FAIL_KEY, { n: n, until: env.now() + wait });
      return { status: 'unknown' };
    }

    function request() {
      var body = new env.FormData();
      body.append('action', 'get_user_hash');
      // credentials: 'include' -- this page is cross-origin from
      // bootstrapworld.org whenever it isn't served from it (the author
      // server, local previews), and the WordPress login cookie has to ride
      // along. The endpoint's CORS allow-list (user-hash-ajax.php in the
      // website repo) decides which origins actually get it.
      return env.fetch(LOOKUP_URL, { method: 'POST', credentials: 'include', body: body })
        .then(function (response) {
          if (!response.ok) throw new Error('HTTP ' + response.status);
          return response.json(); // throws on an HTML challenge page
        })
        .then(function (data) {
          if (data && data.success === true && typeof data.data === 'string' && data.data) {
            return remember({ status: 'in', hash: data.data, t: env.now() });
          }
          if (data && data.success === false && data.data && typeof data.data.message === 'string') {
            return remember({ status: 'out', t: env.now() });
          }
          throw new Error('unexpected response');
        })
        .catch(fail);
    }

    // Runs once the lock (if any) is ours: another tab may have just filled
    // the burst entry while we waited.
    function lookup() {
      var burst = usableEntry(read(env.localStorage, BURST_KEY), BURST_TTL, BURST_TTL);
      if (burst) return Promise.resolve(remember(burst, true));
      return request();
    }

    function lookupUnderLock() {
      var locks = env.locks;
      if (!locks || !locks.request) return lookup();
      var controller = env.AbortController ? new env.AbortController() : null;
      var timer = controller && env.setTimeout(function () { controller.abort(); }, LOCK_WAIT);
      var opts = controller ? { signal: controller.signal } : {};
      return locks.request('bw-identity', opts, function () {
        if (timer) env.clearTimeout(timer); // got the lock; the wait is over
        return lookup();
      }).catch(function () {
        // Couldn't get the lock in time (or no lock support): just look.
        return lookup();
      });
    }

    function resolveIdentity() {
      var cached = usableEntry(read(env.sessionStorage, SESSION_KEY), TTL_IN, TTL_OUT);
      if (cached) return Promise.resolve(toIdentity(cached));
      var failed = read(env.sessionStorage, FAIL_KEY);
      if (failed && failed.until > env.now()) return Promise.resolve({ status: 'unknown' });
      return lookupUnderLock();
    }

    function getUserIdentity() {
      if (memo) return Promise.resolve(memo);
      if (!inflight) {
        inflight = resolveIdentity().then(function (identity) {
          if (identity.status !== 'unknown') memo = identity; // never keep a failure
          inflight = null;
          return identity;
        });
      }
      return inflight;
    }

    // Came from the WordPress side of the site (where people log in and out)?
    // The curriculum itself lives under /materials/ on the same host.
    function cameFromWordPress() {
      try {
        var ref = new env.URL(env.referrer);
        return (ref.hostname === 'bootstrapworld.org' || ref.hostname === 'www.bootstrapworld.org')
          && ref.pathname.indexOf('/materials/') !== 0;
      } catch (e) { return false; }
    }

    function isAccountLink(href) {
      return /bootstrapworld\.org\/(my-account|wp-login)|logout/i.test(href || '');
    }

    if (cameFromWordPress()) clear();
    if (env.document && env.document.addEventListener) {
      env.document.addEventListener('click', function (event) {
        var node = event.target;
        while (node && !(node.href !== undefined && node.nodeName === 'A')) node = node.parentNode;
        if (node && isAccountLink(node.href)) clear();
      }, true);
    }

    return { getUserIdentity: getUserIdentity, clear: clear };
  }

  if (typeof module !== 'undefined' && module.exports) {
    module.exports = makeIdentity;
    return;
  }

  function safeStorage(name) {
    try { return root[name]; } catch (e) { return undefined; }
  }
  var identity = makeIdentity({
    fetch: function (url, opts) { return root.fetch(url, opts); },
    FormData: root.FormData,
    URL: root.URL,
    AbortController: root.AbortController,
    setTimeout: function (fn, ms) { return root.setTimeout(fn, ms); },
    clearTimeout: function (id) { root.clearTimeout(id); },
    now: function () { return Date.now(); },
    sessionStorage: safeStorage('sessionStorage'),
    localStorage: safeStorage('localStorage'),
    locks: root.navigator && root.navigator.locks,
    document: root.document,
    referrer: root.document ? root.document.referrer : ''
  });
  root.getUserIdentity = identity.getUserIdentity;
  root.clearUserIdentity = identity.clear;
  root.__userHashPromise = identity.getUserIdentity().then(function (i) { return i.hash; });
})(typeof window !== 'undefined' ? window : this);
