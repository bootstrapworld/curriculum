#!/bin/bash

# last modified 2023-03-06

running_macOS=

(echo $OSTYPE | grep -q darwin) && running_macOS=yes

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      test "$dd" -nt "$d" && touch -r "$dd" "$d"
    elif test -f "$dd" -a -n "$running_macOS"; then
      local d_t=$(date +%s -r "$d")
      local dd_t=$(date +%s -r "$dd")
      test $dd_t -gt $d_t && touch -r "$dd" "$d"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && hoist "$dir"
done

exit 0
