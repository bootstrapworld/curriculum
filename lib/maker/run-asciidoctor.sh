#!/bin/bash

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

test -s "$ADOC_INPUT" || exit 0

# echo calling asciidoctor in dir $(pwd)

cssfile=$TOPDIR/distribution/$NATLANG/lib/curriculum.css

errfile=.make.error.log

rm -f $errfile

if git rev-parse --show-toplevel >/dev/null 2>/dev/null; then
  export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
else
  export SOURCE_DATE_EPOCH=$(date -d $(date +%Y-%m-%d) +%s)
fi

if test -z "$ASCIIDOCTOR_NODE"; then
  if test -z "$DEBUGADOC"; then
    asciidoctor -a linkcss -a stylesheet=$cssfile -a cachedir=.cached/ -B . $(cat $ADOC_INPUT) > $errfile 2>&1
  else
    echo $'\e[1;31m'🐌 Will be slow! Running asciidoctor once per file because DEBUGADOC=$DEBUGADOC $'\e[0m'
    for f in $(cat $ADOC_INPUT); do
      rm -f $errfile; touch $errfile
      # echo asciidoctor $f
      echo -n .
      asciidoctor -a linkcss -a stylesheet=$cssfile -a cachedir=.cached/ -B . $f > $errfile 2>&1
      if test -s "$errfile"; then
        echo
        echo Error occurred while asciidoctoring $f
        cat $errfile
      fi
    done
    echo
  fi
else
  NODE_ADOC_INPUT=$ADOC_INPUT-node.js
  echo "let adocFiles = [" > $NODE_ADOC_INPUT
  cat $ADOC_INPUT | $SED -e 's/.*/"\0",/' >> $NODE_ADOC_INPUT
  echo "];" >> $NODE_ADOC_INPUT
  echo "module.exports = adocFiles;" >> $NODE_ADOC_INPUT
  #
  node lib/callAdoc.js $NODE_ADOC_INPUT 
fi

if test -f $errfile; then
  test -s $errfile || rm -f $errfile
fi
