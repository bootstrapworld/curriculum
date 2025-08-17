#! /usr/bin/env bash
# last modified 2025-07-11

function updateLangTimestamp() {
  local d=$1
  local dd
  for dd in "$d"/*; do
    # if the parent is a langs directory, it's the language folder for a lesson
    # set the modification date to be that of the most-recently modified file
    if [[ $d = *langs ]]; then
      touch -mr $(find $dd -type f -print0 | xargs -0 stat --format '%Y %n' | sort -nr | cut -d' ' -f2- | head -1) $dd
    # if it's a directory that is NOT a lesson, walk through it looking for lessons
    elif test -d "$dd"; then
      updateLangTimestamp "$dd"
    fi
  done
}

for dir in "$@"; do
  test -d "$dir" && updateLangTimestamp "$dir"
done

exit 0
