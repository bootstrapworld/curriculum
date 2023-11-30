#!/bin/bash

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

test -f "$ADOC_INPUT" || exit 0

# echo calling asciidoctor in dir $(pwd)

if test -z "$ASCIIDOCTOR_NODE"; then
  if test -z "$DEBUGADOC"; then
    asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $(cat $ADOC_INPUT)
  else
    echo 🐌 Will be slow! Running asciidoctor once per file because DEBUGADOC = $DEBUGADOC
    errfile=.error.tmp
    for f in $(cat $ADOC_INPUT); do
      rm -f $errfile; touch $errfile
      # echo asciidoctor $f
      asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $f > $errfile 2>&1
      if test -s "$errfile"; then
        echo Error occurred while asciidoctoring $f
        cat $errfile
      fi
    done
  fi
else
  NODE_ADOC_INPUT=$ADOC_INPUT-node.js
  echo "let adocFiles = [" > $NODE_ADOC_INPUT
  cat $ADOC_INPUT | sed -e 's/.*/"\0",/' >> $NODE_ADOC_INPUT
  echo "];" >> $NODE_ADOC_INPUT
  echo "module.exports = adocFiles;" >> $NODE_ADOC_INPUT
  #
  node lib/callAdoc.js $NODE_ADOC_INPUT 
fi
