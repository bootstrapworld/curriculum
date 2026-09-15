<!-- Agent-written (Claude Opus 5) at Joe Politz's request. Please review/reword before merge. -->

# starter-file-tests

Runs every Pyret starter file `shared/langs/<lang>/starterFiles/*.json` links to
through a headless browser against a deployed Pyret editor, and reports
pass / expected-error / broken.

```bash
npm ci
npx playwright install --with-deps chromium
node run.js                       # the whole registry
node run.js --list                # what would run, and what is skipped and why
node run.js --grep=bug-hunting    # one starter file
```

`PYRET_HOST` picks the deployment (default `https://pyret.bootstrapworld.org`).
Point it at a local `code.pyret.org` to bisect a Pyret-side regression:

```bash
PYRET_HOST=http://localhost:4999 node run.js
```

Flags: `--lang` (default `en-us`), `--jobs` (default 4), `--retries` (default 1),
`--grep=<regex>`, `--json=<path>`, `--summary=<path>` (GitHub-flavored markdown),
`--update-expectations`.

## Outcomes and verdicts

An *outcome* is what the editor did; a *verdict* compares that to
`expectations.json`.

| outcome | meaning |
|---|---|
| `ok` | ran to completion, nothing errored, any check/examples blocks passed |
| `interactive` | opened a dialog and kept running — `reactor.interact()`/`animate` open a Reactor dialog, `display-chart` an Interactive Chart one; both stay live until a person closes them |
| `error` | the editor reported a compile or runtime error |
| `tests-failed` | ran, but check/examples blocks failed |
| `missing-file` | the starter file URL 404s, so the editor loaded GitHub's 404 page as the program |

Unlisted starter files are expected to be `ok` or `interactive`. `expectations.json`
records the rest:

```json
{ "expectations": {
  "bug-hunting": { "expect": "error", "errorContains": "didn't understand", "reason": "…" },
  "pulsing-star": { "expect": "interactive" },
  "alg2-cheerios": { "expect": "interactive" }
} }
```

`missing-file` is always broken and cannot be expected away.

Anything that stops a starter file from being tested at all — navigation
failure, the editor never booting, Run producing no run — is reported separately
as `UNVERIFIED`, never as a curriculum failure. That is the `ProceduralError` vs
`AssertionError` split from `pyret-lang/browser-test`.

Exit code is 1 if anything is BROKEN, 0 otherwise (UNVERIFIED does not fail the
run; read the report).

## GitHub Action

`.github/workflows/starter_file_tests.yml`, manual trigger (**Actions → Starter
File Tests → Run workflow**). Inputs: host, jobs, grep, lang. Writes a summary
table to the run page and uploads `results.json`.
