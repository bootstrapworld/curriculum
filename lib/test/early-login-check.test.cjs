// Run with:  node --test lib/test/
// Drives lib/early-login-check.js with a fake fetch, storage, clock and Web Locks.
const test = require('node:test');
const assert = require('node:assert/strict');
const makeIdentity = require('../early-login-check.js');

const HASH = 'a'.repeat(64);
const IN = { success: true, data: HASH };
const OUT = { success: false, data: { message: 'User not logged in.' } };
const SEC = 1000, MIN = 60 * SEC;

function fakeStorage(throwing) {
  const m = new Map();
  return {
    getItem: (k) => { if (throwing) throw new Error('denied'); return m.has(k) ? m.get(k) : null; },
    setItem: (k, v) => { if (throwing) throw new Error('denied'); m.set(k, String(v)); },
    removeItem: (k) => { if (throwing) throw new Error('denied'); m.delete(k); },
    keys: () => [...m.keys()],
  };
}

// A world is the browser: one clock, one localStorage, one lock manager, one
// server. Each tab() adds its own sessionStorage and page memory.
function world(respond) {
  const w = { t: 1e12, calls: 0, local: fakeStorage(), queue: Promise.resolve(), respond };
  w.fetch = async () => {
    w.calls++;
    return w.respond();
  };
  w.locks = { // serialize requests, like navigator.locks does for one name
    request: (name, opts, cb) => {
      const run = w.queue.then(cb);
      w.queue = run.catch(() => {});
      return run;
    },
  };
  w.tab = (extra) => makeIdentity(Object.assign({
    fetch: w.fetch, FormData: class { append() {} }, URL,
    AbortController, setTimeout: () => 0, clearTimeout: () => {},
    now: () => w.t, sessionStorage: fakeStorage(), localStorage: w.local,
    locks: w.locks, document: null, referrer: '',
  }, extra));
  return w;
}
const json = (body, status = 200) => () => ({ ok: status < 400, status, json: async () => body });

test('concurrent callers on a page share one request', async () => {
  const w = world(json(IN));
  const id = w.tab();
  const results = await Promise.all([id.getUserIdentity(), id.getUserIdentity(), id.getUserIdentity()]);
  assert.equal(w.calls, 1);
  assert.deepEqual(results[0], { status: 'in', hash: HASH });
});

test('logged in: a reload in the same tab reuses it for 5 minutes, then looks again', async () => {
  const w = world(json(IN));
  const session = fakeStorage();
  await w.tab({ sessionStorage: session }).getUserIdentity();
  w.t += 4 * MIN + 59 * SEC;
  w.local.removeItem('bw.identity.burst'); // isolate the per-tab layer
  await w.tab({ sessionStorage: session }).getUserIdentity();
  assert.equal(w.calls, 1);
  w.t += 2 * SEC;
  await w.tab({ sessionStorage: session }).getUserIdentity();
  assert.equal(w.calls, 2);
});

test('logged out is cached only 30 seconds', async () => {
  const w = world(json(OUT));
  const session = fakeStorage();
  const first = await w.tab({ sessionStorage: session }).getUserIdentity();
  assert.deepEqual(first, { status: 'out' });
  w.t += 29 * SEC;
  w.local.removeItem('bw.identity.burst');
  await w.tab({ sessionStorage: session }).getUserIdentity();
  assert.equal(w.calls, 1);
  w.t += 2 * SEC;
  await w.tab({ sessionStorage: session }).getUserIdentity();
  assert.equal(w.calls, 2);
});

test('a burst of separate tabs makes one request; the shared entry expires after 15 s', async () => {
  const w = world(json(IN));
  const results = await Promise.all([w.tab(), w.tab(), w.tab(), w.tab()].map((t) => t.getUserIdentity()));
  assert.equal(w.calls, 1);
  assert.ok(results.every((r) => r.hash === HASH));
  w.t += 14 * SEC;
  await w.tab().getUserIdentity(); // a brand-new tab: its own empty sessionStorage
  assert.equal(w.calls, 1);
  w.t += 2 * SEC;
  await w.tab().getUserIdentity();
  assert.equal(w.calls, 2);
});

test('without Web Locks it still works (a burst may cost extra requests)', async () => {
  const w = world(json(IN));
  const id = await w.tab({ locks: undefined }).getUserIdentity();
  assert.equal(id.hash, HASH);
});

for (const [name, respond] of [
  ['HTTP 503', json({}, 503)],
  ['non-JSON (challenge page)', () => ({ ok: true, status: 200, json: async () => { throw new SyntaxError('<html>'); } })],
  ['network error', () => { throw new TypeError('Failed to fetch'); }],
  ['unexpected JSON', json({ hello: 'world' })],
  ['success without a hash', json({ success: true, data: '' })],
]) {
  test(`failure (${name}): resolves unknown, caches nothing, backs off`, async () => {
    const w = world(respond);
    const session = fakeStorage();
    const id = await w.tab({ sessionStorage: session }).getUserIdentity();
    assert.deepEqual(id, { status: 'unknown' });
    assert.equal(w.local.getItem('bw.identity.burst'), null);
    assert.equal(session.getItem('bw.identity.v1'), null);
    // a reload right away does not retry...
    const again = await w.tab({ sessionStorage: session }).getUserIdentity();
    assert.deepEqual(again, { status: 'unknown' });
    assert.equal(w.calls, 1);
    // ...but once the pause is over it does, and a good answer is then kept
    w.respond = json(IN);
    w.t += 31 * SEC;
    const recovered = await w.tab({ sessionStorage: session }).getUserIdentity();
    assert.equal(recovered.hash, HASH);
    assert.equal(w.calls, 2);
  });
}

test('repeated failures back off exponentially, up to 5 minutes', async () => {
  const w = world(json({}, 500));
  const session = fakeStorage();
  const attempt = () => w.tab({ sessionStorage: session }).getUserIdentity();
  await attempt();                      // fails; pause 30 s
  w.t += 31 * SEC; await attempt();     // fails; pause 60 s
  w.t += 31 * SEC; await attempt();     // still paused
  assert.equal(w.calls, 2);
  w.t += 30 * SEC; await attempt();     // 61 s since the second failure
  assert.equal(w.calls, 3);
});

test('unavailable storage does not break lookups', async () => {
  const w = world(json(IN));
  const id = await w.tab({ sessionStorage: fakeStorage(true), localStorage: fakeStorage(true) }).getUserIdentity();
  assert.equal(id.hash, HASH);
});

test('arriving from the WordPress site drops the cached identity', async () => {
  const w = world(json(IN));
  const session = fakeStorage();
  await w.tab({ sessionStorage: session }).getUserIdentity();
  await w.tab({ sessionStorage: session, referrer: 'https://bootstrapworld.org/materials/fall2026/en-us/lessons/x/' }).getUserIdentity();
  assert.equal(w.calls, 1, 'a curriculum page is not the WordPress site');
  await w.tab({ sessionStorage: session, referrer: 'https://bootstrapworld.org/my-account/' }).getUserIdentity();
  assert.equal(w.calls, 2);
});

test('clicking a login/logout/my-account link drops it for every tab', async () => {
  const w = world(json(IN));
  let onClick;
  const doc = { addEventListener: (type, fn) => { if (type === 'click') onClick = fn; } };
  const tab = w.tab({ document: doc });
  await tab.getUserIdentity();
  onClick({ target: { nodeName: 'DIV', parentNode: { nodeName: 'A', href: 'https://bootstrapworld.org/lessons/' } } });
  assert.notEqual(w.local.getItem('bw.identity.burst'), null, 'an ordinary link leaves it alone');
  onClick({ target: { nodeName: 'SPAN', parentNode: { nodeName: 'A', href: 'https://bootstrapworld.org/my-account/' } } });
  assert.equal(w.local.getItem('bw.identity.burst'), null);
});
