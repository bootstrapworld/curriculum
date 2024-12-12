#!/bin/sh

# checks if a committed adoc file has a multi-line proglang.txt alongside it,
# and if so, checks that newly added text, if more than $minchars characters, does contain @ifproglang.
# If not, issue warning

minchars=200

for f in $(git diff --name-only --staged); do
  if test ! -f $f; then continue; fi
  fb=$(basename $f)
  test ${fb#*.} = adoc || continue
  d=$(dirname $f)
  proglangfile=$d/proglang.txt
  test -f $proglangfile || continue
  test $(grep -c . $proglangfile) -gt 1 || continue
  test $(git -c diff.tool=vimdiff diff --staged -- $f|grep '^+'|wc -c) -lt $minchars && continue
  git diff --staged -- $f|grep '^+'|grep -q @ifproglang && continue
  echo WARNING: $f did not have any @ifproglang\'s
done
