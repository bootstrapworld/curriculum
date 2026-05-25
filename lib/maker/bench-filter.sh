#! /usr/bin/env bash
#
# Reads build output from stdin, passes it through unchanged, and prints a
# per-step timing summary at the end. Each "➤ ..." progress marker becomes
# a row in the table.
#
# Used by the top-level `phases` target in Makefile.all to add timing info
# to every build, without changing the `make` UX.

# Pick the highest-resolution date command available.
if command -v gdate >/dev/null 2>&1; then
  now() { gdate +%s.%N; }
else
  now() { date +%s; }                          # fallback: whole-second precision
fi

logfile=$(mktemp -t curriculum-bench.XXXXXX)
trap 'rm -f "$logfile"' EXIT

start_ts=$(now)

while IFS= read -r line; do
  printf '%s\n' "$line"
  case "$line" in
    *➤*) printf '%s %s\n' "$(now)" "$line" >> "$logfile" ;;
  esac
done

end_ts=$(now)

# Render the summary table. Skip when there are no ➤ markers (e.g. an
# already-up-to-date build where Make printed nothing of interest).
if test -s "$logfile"; then
  echo
  echo "================================================================"
  echo " Build timing summary"
  echo "================================================================"
  awk -v end_ts="$end_ts" -v start_ts="$start_ts" '
  {
    ts = $1
    msg = $0
    sub(/^[0-9.]+ +/, "", msg)        # strip leading timestamp
    sub(/^.*➤[[:space:]]*/, "", msg)  # strip everything up to and including ➤
    if (NR > 1) {
      printf "  %-52s %7.2fs\n", prev_label, ts - prev_ts
    }
    prev_ts = ts
    prev_label = msg
  }
  END {
    if (NR > 0) {
      printf "  %-52s %7.2fs\n", prev_label, end_ts - prev_ts
      print "  ---------------------------------------------------- --------"
      printf "  %-52s %7.2fs\n", "TOTAL", end_ts - start_ts
    }
  }
  ' "$logfile"
  echo "================================================================"
fi
