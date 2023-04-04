#!/bin/bash

# last modified 2023-04-04

TOUCH=touch

running_problematic_OS=

running_macOS=

(echo $OSTYPE | grep -q darwin) && running_macOS=yes

test -n "$running_macOS" && running_problematic_OS=yes

test "$WSL_DISTRO_NAME" = Ubuntu && running_problematic_OS=yes

test -n "$running_macOS" && TOUCH=gtouch

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      test "$dd" -nt "$d" && $TOUCH -r "$dd" "$d"
    elif test -f "$dd" -a -n "$running_problematic_OS"; then
      local d_t=$(date +%s -r "$d")
      local dd_t=$(date +%s -r "$dd")
      test $dd_t -gt $d_t && $TOUCH -r "$dd" "$d"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && hoist "$dir"
done

exit 0
