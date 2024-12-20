#!/bin/sh

# checks if a committed adoc file has a multi-line proglang.txt alongside it,
# and if so, checks that newly added text, if more than $minchars characters, does contain @ifproglang.
# If not, issue warning

minchars=200

JQ=$(which jq)

for f in $(git diff --name-only --staged); do
  if test ! -f $f; then continue; fi
  fb=$(basename $f)
  if test ${fb#*.} = adoc; then
    for doit in justonce; do
      d=$(dirname $f)
      proglangfile=$d/proglang.txt
      test -f $proglangfile || continue
      test $(grep -c . $proglangfile) -gt 1 || continue
      test $(git -c diff.tool=vimdiff diff --staged -- $f|grep '^+'|wc -c) -lt $minchars && continue
      git diff --staged -- $f|grep '^+'|grep -q @ifproglang && continue
      echo WARNING: $f did not have any @ifproglang\'s
    done

    for doit in justonce; do
      git diff --staged -- $f|grep '^+'|grep -v '^+++'|node lib/spellcheck.js $f
    done

  elif test ${fb#*.} = json; then
    test -z "$JQ" && continue
    cat $f|$JQ -e >/dev/null 2>&1 && continue
    echo ERROR: $f is invalid JSON
    exit 1

  else continue
  fi
done
