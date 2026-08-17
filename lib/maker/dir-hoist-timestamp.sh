#! /usr/bin/env bash
# last modified 2026-08-17
#
# For every language directory (a child of a directory named "langs"), set its
# mtime to that of the most-recently-modified file beneath it, so make can use
# the directory's timestamp to decide whether the lesson needs rebuilding.
#
# Single pass: one find for the files, batched stat, one awk to pick the newest
# file per language directory, one touch per directory. The previous version
# spawned a 6-process pipeline per language directory (~1000 processes).

dirs=()
for dir in "$@"; do
  test -d "$dir" && dirs+=("$dir")
done
test ${#dirs[@]} -gt 0 || exit 0

find "${dirs[@]}" -type f -path '*/langs/*/*' -print0 |
  xargs -0 stat --format '%Y %n' |
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
