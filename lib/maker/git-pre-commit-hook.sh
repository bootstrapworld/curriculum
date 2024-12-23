#!/bin/sh

# checks if a committed adoc file has a multi-line proglang.txt alongside it,
# and if so, checks that newly added text, if more than $minchars characters, does contain @ifproglang.
# If not, issue warning

minchars=200

JQ=$(which jq)

COMMITHOOK_PROGLANG=distribution/.commithook.proglang.log
COMMITHOOK_SPELLCHECK=distribution/.commithook.spellcheck.log
COMMITHOOK_BADJSON=distribution/.commithook.badjson.log

rm -f $COMMITHOOK_PROGLANG $COMMITHOOK_SPELLCHECK $COMMITHOOK_BADJSON

touch $COMMITHOOK_PROGLANG $COMMITHOOK_SPELLCHECK $COMMITHOOK_BADJSON

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
      echo WARNING: $f did not have any @ifproglang\'s >> $COMMITHOOK_PROGLANG
    done

    for doit in justonce; do
      git diff --staged -- $f|grep '^+'|grep -v '^+++'|node lib/spellcheck.js $f >> $COMMITHOOK_SPELLCHECK
    done

  elif test ${fb#*.} = json; then
    test -z "$JQ" && continue
    cat $f|$JQ -e >/dev/null 2>&1 && continue
    echo ERROR: $f is invalid JSON >> $COMMITHOOK_BADJSON
    break

  else continue
  fi
done

cat $COMMITHOOK_PROGLANG
cat $COMMITHOOK_SPELLCHECK
cat $COMMITHOOK_BADJSON
