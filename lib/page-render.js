/*
 * page-render.js — per-page rendering (MathJax, CodeMirror, tables, blanklines)
 *
 * Loaded on every content page, including workbook pages.
 *
 * Split out of the former lib/bootstraplesson.js. Relies on globals loaded by
 * sibling <script> tags; see lib/maker/do-postproc.lua for load wiring.
 */

/*******************************************
 * MATHJAX configuration
 *******************************************/
// for pages that use mathjax, this is the configuration string
// for those that don't, this is basically a no-op
MathJax = {
  loader:  { load: ['a11y/assistive-mml'] },
  options: { enableMenu: false, },
  tex:     {
    inlineMath: [['$$', '$$'], ['\\(', '\\)']],
    displayMath: [],
  },
  svg:     { fontCache: 'global' },
  startup: {
    ready: () => {
      MathJax.startup.defaultReady();
      MathJax.startup.promise
        .then(() => {
          window.status = "MathJax Complete!";
        })
        .catch((err) => {
          console.error("MathJax startup failed:", err);
          window.status = "MathJax Failed!";
        });
    }
  }
};

/*******************************************
 * CODEMIRROR
 *******************************************/
// translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
// (we use the more expensive CM stuff for indenting)
function attachCodeMirror() {
  if(typeof CodeMirror == "undefined") return;
  const codeSnippets = document.querySelectorAll(
    "code.pyret, code.racket, tt.pyret, tt.racket"
  );

  // There are subtle differences between full-blown CM + runMode addon and standalone-runmode
  // CM+runmode emits <br> tags in place of \n, but standalone-runmode preserves the \n
  // With our CSS rules, this winds up causing discrepancies in the output!
  // Fortunately, we can pass in a function that replicates the normal behavior EXCEPT
  // for the way newlines are processed. This function does just that, and wraps the runMode
  // call as runModeToHTML
  function runModeToHTML(code, mode, options) {
    options = options || {};
    var tabSize = options.tabSize || CodeMirror.defaults.tabSize;
    var html = "", col = 0;

    function esc(s) {
      return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }

    CodeMirror.runMode(code, mode, function (text, style) {
      // THIS IS THE ONE LINE THAT FIXES \n!!!
      if (text === "\n") { html += "<br>"; col = 0; return; }
      // EVERYTHING ELSE JUST COPIES THE DEFAULT CODE PATH
      var content = "";
      for (var pos = 0;;) {
        var idx = text.indexOf("\t", pos);
        if (idx === -1) { content += text.slice(pos); col += text.length - pos; break; }
        col += idx - pos;
        content += text.slice(pos, idx);
        var size = tabSize - col % tabSize;
        col += size;
        for (var i = 0; i < size; ++i) content += " ";
        pos = idx + 1;
      }
      content = esc(content);
      html += style
        ? '<span class="cm-' + style.replace(/ +/g, " cm-") + '">' + content + "</span>"
        : content;
    }, options);

    return html;
  }

  try {
    codeSnippets.forEach(function (tt, idx) {
      const node = document.createElement("span");
      node.className = "editbox";
      tt.parentNode.insertBefore(node, tt);
      const mode = tt.className == "racket"? "scheme2" : "pyret";
      node.innerHTML = runModeToHTML(tt.firstChild.nodeValue, mode);
      tt.style.display = "none";
    })
  } catch(e) {
    console.error(e);
  }
}

/*******************************************
 * Stretch Tables
 *******************************************/
// tables with class .stretch need their colgroup settings
// manually-translated into css grid template rules
function fixStretchTables() {
  // if there's no header, use "auto" for row heights
  const tables = document.querySelectorAll('#body.workbookpage table.FillVerticalSpace');
  tables.forEach (t => {
    if(!t.querySelector(':scope > thead')) {
      t.style.gridTemplateRows = 'auto';
    }
    const cols = [...t.querySelector('colgroup').children];
    t.style.gridTemplateColumns = cols.map(c => c.style.width).join(" ")
  });
}

/*******************************************
 * Blanklines
 *******************************************/
function drawBlankLines() {
  document.querySelectorAll('.blanklines').forEach(n => {
    // .blanklines derives its height from .fitb/.fitbruby, which is set
    // via --blank-pitch (see core.less). Use getComputedStyle instead of
    // getBoundingClientRect to account for browser zoom
    const pitch = parseFloat(getComputedStyle(n).lineHeight);

    // How many lines? The @blanklines macro records the
    // count in data-lines; fall back to deriving it from the reserved
    // height, which the macro sets to n * pitch.
    const requested = parseInt(n.dataset.lines, 10);
    const nLines = requested > 0 ? requested
      : Math.max(1, Math.round(n.offsetHeight / pitch));

    // Draw one rule per writing line. SVG lines fall ON a pixel boundary,
    // not above it -- so subtract 0.5px to pull it entirely above the
    // bottom of the box *and* prevent anti-aliasing
    let dataUrl = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg">';
    for (let i = 1; i <= nLines; i++) {
      const y = (i * pitch - 0.5).toFixed(1);
      dataUrl += `<line x1="0" y1="${y}" x2="1000" y2="${y}" style="stroke:black;stroke-width:1"/>`;
    }
    dataUrl += '</svg>';

    // Reserve exactly the height of a stack of nLines fitb paragraphs, so
    // the block takes up the same room whether it's drawn as @blanklines
    // or as a run of @fitb lines.
    n.style.height = `${nLines * pitch}px`;
    n.style.backgroundRepeat = 'no-repeat';
    n.style.backgroundImage = `url('${dataUrl}')`;
  });
}

/*******************************************
 * User Identity
 *******************************************/
// If the user is logged in to bootstrapworld.org, we'll get a salted hash
// about them. Lives here (rather than in graph-pages.js) because this file
// is the one loaded on every page, including workbook pages; graph-pages.js
// is not. graph-pages.js's populateQuizLinks() also calls this, as a global.
async function fetchUserHash() {
  // early-login-check.js fires this same request as early as <head> allows,
  // long before anything would otherwise call fetchUserHash(). Prefer its
  // in-flight (or already-resolved) promise; only fire our own request if
  // that script wasn't present on this page.
  if (window.__userHashPromise) {
    return window.__userHashPromise;
  }

  const formData = new FormData();
  formData.append('action', 'get_user_hash');

  try {
    const response = await fetch('https://bootstrapworld.org/wp-admin/admin-ajax.php', {
      method: 'POST',
      body: formData
    });
    const data = await response.json();
    if (data.success) {
      console.log('User Hash is:', data.data);
      return data.data;
    } else {
      console.error('Error:', data.data.message);
      return undefined;
    }
  } catch (error) {
    console.error('Network error:', error);
    return undefined;
  }
}

// Tag starter-file links with the (salted, hashed) identity of whoever is
// logged in, so we can tell which teacher's students are using a given
// starter file. If nobody's logged in (or the request fails), fetchUserHash
// resolves to undefined and we bail before touching any link, leaving hrefs
// exactly as preproc.rkt generated them.
async function populateStarterFileLinks() {
  const starterFileLinks = document.querySelectorAll('a.starterFileLink');
  if (starterFileLinks.length === 0) return;
  const teacherID = await fetchUserHash();
  if (!teacherID) return;
  starterFileLinks.forEach( link => {
    // Pyret starter-file links point at pyret.bootstrapworld.org/editor#shareurl=<rawUrl>.
    // PBO parses the whole fragment as one query string (url.parse("/?" +
    // location.hash)), so `?` has no special meaning inside it -- it would
    // just get absorbed into the shareurl value instead of becoming a
    // separate key. Any link with a `#` (this shape) or an existing `?`
    // (e.g. a wescheme openEditor URL) needs `&` to add a new key; only a
    // link with neither gets a leading `?`.
    const sep = (link.href.includes('#') || link.href.includes('?')) ? '&' : '?';
    link.href += `${sep}teacherID=${teacherID}`;
  })
}

/*******************************************
 * EVENT HANDLERS
 *******************************************/
// These run on every page (workbook pages included).
if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => {
    fixStretchTables();
    attachCodeMirror();
    drawBlankLines();
    populateStarterFileLinks();
  });
}
