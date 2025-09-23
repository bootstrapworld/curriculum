#! /usr/bin/env bash

pyret_files_dir=$(pwd)/shared/langs/en-us/pyret-files

while IFS= read -r pyret_file; do
  if ! pyret -c "$pyret_file" 2>&1 | grep -q 'Cleaning up'; then
    echo WARNING: Could not compile $(realpath "$pyret_file" --relative-to=$pyret_files_dir)
  fi
done < <(find $pyret_files_dir -type f -name \*.arr)
