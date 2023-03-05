#!/bin/bash

# last modified 2023-03-05

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      test "$dd" -nt "$d" && touch -r "$dd" "$d"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && hoist "$dir"
done
