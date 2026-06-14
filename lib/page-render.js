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
  const nodes = document.querySelectorAll('.blanklines');
  nodes.forEach( n => {
      const computedStyle = window.getComputedStyle(n);

      // The rules must line up with @fitb writing lines elsewhere on the page.
      // A fitb's pitch is NOT its 2.2em line-height: when fitbs are stacked
      // (one per paragraph) the spacing is set by the paragraph's line box,
      // which is taller than the fitb's own box. Font metrics make this hard to
      // compute, so measure it directly: drop two stacked `.fitb.stretch` lines
      // into the same styling context, read the real pitch and the offset of
      // the underline within its band, then reproduce both here.
      //
      // The background SVG and the height we set below live in layout pixels,
      // but the workbook page applies `zoom`, which scales getBoundingClientRect
      // (sub-pixel) without changing layout pixels. So measure the rig with
      // getBoundingClientRect for precision, then divide by the page zoom to
      // convert back to layout pixels. The zoom is derived generically as
      // rect.height / offsetHeight, so this is correct at zoom: 1 too.
      const host = n.parentNode.parentNode || n.parentNode || document.body;
      const rig = document.createElement('div');
      rig.style.cssText = 'visibility:hidden;position:absolute;left:-9999px;top:0';
      rig.style.width = n.offsetWidth + 'px';
      rig.innerHTML = '<p><span class="fitb stretch"></span></p>' +
                      '<p><span class="fitb stretch"></span></p>';
      host.appendChild(rig);
      const p1 = rig.children[0], f1 = p1.querySelector('.fitb');
      const zoom = (rig.getBoundingClientRect().height / rig.offsetHeight) || 1;
      const p1Top = p1.getBoundingClientRect().top;
      const pitch = (rig.children[1].getBoundingClientRect().top - p1Top - 2) / zoom;
      // the visible underline is the fitb's ::after, sitting ~1px below its box
      const firstLineY =
        (f1.getBoundingClientRect().bottom - p1Top - 3) / zoom + 1;
      host.removeChild(rig);

      // How many lines were requested? The @blanklines macro records the count
      // in data-lines; fall back to deriving it from the reserved height, which
      // the macro sets to n * 2.2em (the element's own line-height).
      const requested = parseInt(n.dataset.lines, 10);
      const nLines = requested > 0 ? requested
        : Math.max(1, Math.round(n.offsetHeight / parseFloat(computedStyle.lineHeight)));

      // Draw one rule per writing line, at the same place a fitb underline sits.
      let dataUrl = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg">';
      for (let i = 0; i < nLines; i++) {
        // round to 0.1px (not whole px) so each rule keeps the exact pitch;
        // under `zoom` whole layout pixels don't map to device pixels anyway
        const y = (firstLineY + i * pitch).toFixed(1) - 4;
        dataUrl += `<line x1="0" y1="${y}" x2="1000" y2="${y}" style="stroke:black;stroke-width:1"/>`;
      }
      dataUrl += '</svg>';

      // Reserve exactly the height of a stack of nLines fitb paragraphs, so the
      // block takes up the same room whether it's drawn as @blanklines or as a
      // run of @fitb lines.
      n.style.height = `round(up, ${nLines * pitch}px, 1px)`;
      n.style.backgroundRepeat = 'no-repeat';
      n.style.backgroundImage = `url('${dataUrl}')`;
      // On solution pages the block holds answer text that should sit ON the
      // rules. The CSS line-height (2.2em) no longer equals the rule pitch, so
      // advance the text at the rule pitch instead; otherwise each wrapped line
      // drifts a couple px above its rule, accumulating down the block.
      n.style.lineHeight = `${pitch}px`;
  });
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
  });
}
