/*
 * In-page port of the bits of code.pyret.org's editor test predicates this
 * suite needs, in the shape pyret-lang/browser-test/shared/page-assertions.js
 * uses: one function, stringified, injected to define window.SFA, everything
 * returning plain JSON.
 *
 * Differences from that file, because this drives *deployed* editors rather
 * than a build of the current tree:
 *
 * - editorReady cannot require EDITOR_CONTENTS_SETTLED. Deployed CPO does not
 *   define it (checked against pyret.bootstrapworld.org); a local CPO built
 *   from current pyret-lang does. So: honour it when present, else fall back
 *   to "loader hidden and CodeMirror non-empty", which is sound here because
 *   the share-URL fetch is the only writer of the definitions CM.
 *
 * - Run start is observed via a sentinel, not polled. #breakButton is disabled
 *   at idle, so "wait until it is disabled" returns instantly and reports a run
 *   that never happened; and a starter file that is all comments (there are
 *   some) never enables it and never renders output, so watching the button or
 *   #output's children misses the run entirely. What is always true is that CPO
 *   empties #output at the start of every run, so beginRun leaves a sentinel
 *   child there and its removal is the start signal.
 *
 * - runState reports dialogs: `reactor.interact()` / `animate` open a jQuery-UI
 *   dialog holding a .repl-animation, and `display-chart` opens an "Interactive
 *   Chart" one. Either way the run stays live until a person closes it, which
 *   for a starter file is a successful run, not a hang. Any visible .ui-dialog
 *   counts -- the editor opens none on its own -- and its title is reported so
 *   the run log says which kind it was.
 */
function PYRET_STARTER_FILE_ASSERTIONS() {
  const SFA = {
    // Marker child dropped into #output before clicking Run; CPO removing it is
    // what tells us a run actually began. Ignored everywhere results are read.
    SENTINEL: "__sfa_run_sentinel__",

    // ---- readiness ----
    pyretLoaded() {
      const loader = document.getElementById("loader");
      if (!loader) return true;
      return getComputedStyle(loader).display === "none";
    },
    cm() {
      const cm = document.querySelector(".CodeMirror");
      return cm && cm.CodeMirror ? cm.CodeMirror : null;
    },
    cmValue() {
      const cm = SFA.cm();
      return cm ? cm.getValue() : null;
    },
    editorReady() {
      if (!SFA.pyretLoaded()) return false;
      const v = SFA.cmValue();
      if (v === null) return false;
      if (window.EDITOR_CONTENTS_SETTLED !== undefined) {
        return window.EDITOR_CONTENTS_SETTLED === true;
      }
      return v.length > 0;
    },
    // stickError banners: runtime-bundle load failure, program load failure,
    // save failure. beforePyret hides #loader while posting one, so
    // pyretLoaded() alone cannot tell a booted runtime from a dead page.
    stickyErrors() {
      return Array.from(document.querySelectorAll(".notificationArea .error"))
        .map((e) => (e.textContent || "").trim())
        .filter((t) => t !== "");
    },

    // ---- run ----
    beginRun() {
      const out = document.getElementById("output");
      const brk = document.getElementById("breakButton");
      const run = document.getElementById("runButton");
      if (!out || !run) return false;
      out.innerHTML = "";
      const sentinel = document.createElement("div");
      sentinel.id = SFA.SENTINEL;
      out.appendChild(sentinel);
      const st = { started: false, sawRunning: false, t0: Date.now(), lastActivity: Date.now() };
      window.__SFA_RUN = st;
      if (brk) {
        st.brkObserver = new MutationObserver(() => {
          st.lastActivity = Date.now();
          if (brk.disabled === false) { st.sawRunning = true; st.started = true; }
        });
        st.brkObserver.observe(brk, { attributes: true, attributeFilter: ["disabled"] });
      }
      st.outObserver = new MutationObserver(() => {
        st.lastActivity = Date.now();
        if (!document.getElementById(SFA.SENTINEL)) st.started = true;
      });
      st.outObserver.observe(out, { childList: true, subtree: true });
      run.click();
      return true;
    },
    openDialogs() {
      return Array.from(document.querySelectorAll(".ui-dialog"))
        .filter((d) => d.offsetParent !== null)
        .map((d) => {
          const t = d.querySelector(".ui-dialog-title");
          const c = d.querySelector(".ui-dialog-content");
          return {
            title: ((t && t.textContent) || "").trim() || "(untitled)",
            animation: !!(c && c.classList.contains("repl-animation")),
          };
        });
    },
    // CPO empties #output the moment Run is pressed but only enables
    // #breakButton once the program is actually executing, so "output cleared
    // and nothing running" is briefly true before any work has happened.
    // Treat the run as over only once we have seen it execute (sawRunning) or
    // produce output -- or, for a program that does neither (all-comments
    // starter files), once the page has been quiet this long.
    QUIET_MS: 8000,

    runState() {
      const st = window.__SFA_RUN || {};
      const brk = document.getElementById("breakButton");
      const out = document.getElementById("output");
      const running = !!brk && brk.disabled === false;
      const cleared = !document.getElementById(SFA.SENTINEL);
      const started = !!st.started || running || cleared;
      const kids = out ? out.children.length : 0;
      const quietFor = Date.now() - (st.lastActivity || st.t0 || Date.now());
      const didSomething = !!st.sawRunning || kids > 0;
      return {
        started: !!started,
        running: running,
        dialogs: SFA.openDialogs(),
        settled: !!started && !running && (didSomething || quietFor > SFA.QUIET_MS),
        outputChildren: kids,
        checkBlocks: out ? out.querySelectorAll(".check-block").length : 0,
        doneRendering: !!document.querySelector(".check-results-done-rendering"),
      };
    },
    endRun() {
      const st = window.__SFA_RUN;
      if (st) {
        if (st.brkObserver) st.brkObserver.disconnect();
        if (st.outObserver) st.outObserver.disconnect();
      }
      return true;
    },
    // Close the dialogs the way a student does, then stop whatever is still
    // running so the context can be torn down cleanly.
    closeDialogs() {
      let closed = 0;
      document.querySelectorAll(".ui-dialog").forEach((d) => {
        if (d.offsetParent === null) return;
        const btn = d.querySelector(".ui-dialog-titlebar-close");
        if (btn) { btn.click(); closed++; }
      });
      const brk = document.getElementById("breakButton");
      if (brk && brk.disabled === false) brk.click();
      return closed;
    },

    // ---- results ----
    // Expand failed/errored check blocks first: their test rows only exist in
    // the DOM once the header has been clicked (same reason util.js clicks).
    collectResult() {
      const out = document.getElementById("output");
      if (!out) return null;
      const stale = document.getElementById(SFA.SENTINEL);
      if (stale) stale.remove();
      const text = out.innerText || "";
      const compileErrors = Array.from(out.querySelectorAll(".compile-error"))
        .map((e) => (e.innerText || "").replace(/\s+/g, " ").trim());
      // Runtime errors render as .error inside #output; the code snippets
      // nested in them are CodeMirrors, so read innerText after ignoring those.
      const runtimeErrors = Array.from(out.querySelectorAll(".error"))
        .filter((e) => !e.closest(".compile-error"))
        .map((e) => (e.innerText || "").replace(/\s+/g, " ").trim())
        .filter((t) => t !== "");
      const blocks = Array.from(out.querySelectorAll(".check-block"));
      const failedBlocks = Array.from(
        out.querySelectorAll(".check-block-failed, .check-block-errored")
      );
      const failures = failedBlocks.map((cb) => {
        const header = cb.querySelector(".check-block-header");
        if (header) header.click();
        const tests = Array.from(cb.querySelectorAll(".check-block-test"));
        return (tests.length === 0 ? [cb] : tests)
          .map((t) => (t.innerText || "").replace(/\s+/g, " ").trim())
          .join(" | ");
      });
      return {
        shipshape: text.indexOf("Looks shipshape") !== -1,
        checkBlocks: blocks.length,
        failedBlocks: failedBlocks.length,
        failures: failures,
        compileErrors: compileErrors,
        runtimeErrors: runtimeErrors,
        stickyErrors: SFA.stickyErrors(),
        // Images/charts render into #output; used only to say "it drew
        // something" in the report, never as a pass/fail signal.
        images: out.querySelectorAll("img, canvas, svg").length,
        outputText: text.replace(/\s+/g, " ").trim().slice(0, 1000),
      };
    },
  };
  window.SFA = SFA;
  return true;
}

const SOURCE = "(" + PYRET_STARTER_FILE_ASSERTIONS.toString() + ")()";

module.exports = { SOURCE };
