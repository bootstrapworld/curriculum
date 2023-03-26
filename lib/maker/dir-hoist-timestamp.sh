#!/bin/bash

# last modified 2023-03-26

running_problematic_OS=

(echo $OSTYPE | grep -q darwin) && running_problematic_OS=yes

test "$WSL_DISTRO_NAME" = Ubuntu && running_problematic_OS=yes

DATE=date

if test -n "$running_problematic_OS"; then
  if which gdate|grep -q .; then
    DATE=gdate
  fi
fi

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      test "$dd" -nt "$d" && touch -r "$dd" "$d"
    elif test -f "$dd" -a -n "$running_problematic_OS"; then
      local d_t=$($DATE +%s -r "$d")
      local dd_t=$($DATE +%s -r "$dd")
      test $dd_t -gt $d_t && touch -r "$dd" "$d"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && hoist "$dir"
done

exit 0
