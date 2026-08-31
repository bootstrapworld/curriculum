/*
 * early-login-check.js — fires the WordPress login-status check as early as
 * technically possible.
 *
 * This must be loaded as a plain, non-deferred, non-async <script src>,
 * placed as close to the very top of <head> as possible -- before every
 * other script -- so the network round-trip to bootstrapworld.org starts
 * immediately, in parallel with everything else the page still has to load
 * (CodeMirror modes, pdf-lib, the dependency graph, etc.), instead of
 * waiting for all of that to finish first.
 *
 * It only fires the request and stashes the resulting Promise on
 * window.__userHashPromise; it never touches the DOM, so it's always safe
 * to run before the DOM exists. fetchUserHash() in page-render.js consumes
 * this promise instead of firing its own, later request.
 */
window.__userHashPromise = (function () {
  var formData = new FormData();
  formData.append('action', 'get_user_hash');

  return fetch('https://bootstrapworld.org/wp-admin/admin-ajax.php', {
    method: 'POST',
    body: formData
  })
    .then(function (response) { return response.json(); })
    .then(function (data) { return data.success ? data.data : undefined; })
    .catch(function () { return undefined; });
})();
