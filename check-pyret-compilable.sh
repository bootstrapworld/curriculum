#! /usr/bin/env bash

pyret_files_dir=$(pwd)/shared/langs/en-us/pyret-files

echo Checking Starter Files for compilation errors... ☠️
while IFS= read -r pyret_file; do
  echo $(realpath "$pyret_file" --relative-to=$pyret_files_dir)
  if ! pyret --builtin-js-dir $pyret_files_dir/libraries/extras/ -c "$pyret_file" 2>&1 | grep -q 'Cleaning up'; then
    echo WARNING: Could not compile $(realpath "$pyret_file" --relative-to=$pyret_files_dir)
  fi
done < <(find $pyret_files_dir -type f -name \*.arr)
