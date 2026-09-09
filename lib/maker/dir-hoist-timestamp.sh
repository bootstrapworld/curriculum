#! /usr/bin/env bash
# last modified 2026-09-08
#
# For every language directory (a child of a directory named "langs"), set its
# mtime to that of the most-recently-modified file beneath it, so make can use
# the directory's timestamp to decide whether the lesson needs rebuilding.
#
# Single pass: one find for the files, batched stat, one awk to pick the newest
# file per language directory, one touch per directory. The previous version
# spawned a 6-process pipeline per language directory (~1000 processes).
#
# When AUTHOR_CHANGED_PATHS is set, it replaces the `find`: author-server.mjs
# sets it (one absolute path per line) to exactly the files its chokidar
# watcher saw change for the build in progress, so there's no reason to stat
# every file under lessons/ and pathways/ just to rediscover what's already
# known. Any other invocation (plain `make`, CI, `make deploy`, or author's
# own first build before any watch event exists) leaves it unset and gets the
# original full scan.

dirs=()
for dir in "$@"; do
  test -d "$dir" && dirs+=("$dir")
done
test ${#dirs[@]} -gt 0 || exit 0

if [ -n "$AUTHOR_CHANGED_PATHS" ]; then
  abs_dirs=()
  for dir in "${dirs[@]}"; do
    abs_dirs+=("$(cd "$dir" && pwd)")
  done
  printf '%s\n' "$AUTHOR_CHANGED_PATHS" | while IFS= read -r f; do
    test -f "$f" || continue
    case "$f" in */langs/*/*) ;; *) continue ;; esac
    for d in "${abs_dirs[@]}"; do
      case "$f" in "$d"/*) printf '%s\0' "$f"; break ;; esac
    done
  done | xargs -0 stat --format '%Y %n' 2>/dev/null
else
  find "${dirs[@]}" -type f -path '*/langs/*/*' -print0 |
    xargs -0 stat --format '%Y %n'
fi |
  awk '
    {
      mtime = $1
      path  = substr($0, index($0, " ") + 1)
      # the language dir is the component immediately following "/langs/"
      if (match(path, /\/langs\/[^\/]+/)) {
        d = substr(path, 1, RSTART + RLENGTH - 1)
        if (mtime > best[d]) { best[d] = mtime; newest[d] = path }
      }
    }
    END { for (d in newest) printf "%s%c%s%c", newest[d], 0, d, 0 }
  ' |
  xargs -0 -n2 touch -mr

exit 0
