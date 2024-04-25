#!/bin/sh

# checks if a committed adoc file has a multi-line proglang.txt alongside it,
# and if so, checks that newly added text, if more than $minlines lines, does contain @ifproglang.
# If not, issue warning

minlines=10

for f in $(git diff --name-only --staged); do
  fb=$(basename $f)
  test ${fb#*.} = adoc || continue
  d=$(dirname $f)
  proglangfile=$d/proglang.txt
  test -f $proglangfile || continue
  test $(grep -c . $proglangfile) -gt 1 || continue
  test $(git diff --staged -- $f|grep -c '^+') -ge $minlines || continue
  test $(git diff --staged -- $f|grep '^+'|grep -c @ifproglang) -eq 0 || continue
  echo WARNING: $f did not have any @ifproglang\'s
done
