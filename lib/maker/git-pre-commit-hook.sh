#!/bin/sh

# checks if a committed adoc file has a multi-line proglang.txt alongside it,
# and if so, checks that newly added text, if more than $minlines lines, does contain @ifproglang.
# If not, issue warning

minlines=10

for f in $(git diff --name-only --staged); do
  fb=$(basename $f)
  if test ${fb#*.} != adoc; then continue; fi
  d=$(dirname $f)
  proglangfile=$d/proglang.txt
  if test -f $proglangfile -a $(grep -c . $proglangfile) -gt 1; then
    if test $(git diff --staged -- $f|grep -c '^+') -gt $minlines -a $(git diff --staged -- $f|grep '^+'|grep -c @ipfproglang) -eq 0; then
      echo WARNING: $f did not have any @ifproglang\'s
    fi
  fi
done
