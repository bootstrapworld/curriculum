#! /usr/bin/env bash

pyret_files_dir=$(pwd)/shared/langs/en-us/pyret-files

function check_pyret_file() {
  local f=$1
  local tmpf
  if test -d "$f"; then
    tmpf=$(mktemp .check-pyret-compilable-XXXXXX.txt)
    ls "$f" > $tmpf
    while read g; do
      check_pyret_file "$f/$g"
    done < $tmpf
    rm $tmpf
  elif test -f "$f"; then
    if echo $f | grep -q '\.arr$'; then
      if pyret -c "$f" 2>&1 | grep -q 'Cleaning up'; then
        :
      else
        echo WARNING: Could not compile $(realpath "$f" --relative-to=$pyret_files_dir)
      fi
    fi
  fi
}

check_pyret_file $pyret_files_dir
