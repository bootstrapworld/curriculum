#!/bin/bash

# last modified 2023-03-06

running_macOS=

test "$OSTYPE" == darwin && running_macOS=yes

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      test "$dd" -nt "$d" && touch -r "$dd" "$d"
    elif test -n "$running_macOS" -a -f "$dd" -a "$dd" -nt "$d"; then
      touch -r "$dd" "$d"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && hoist "$dir"
done

exit 0
