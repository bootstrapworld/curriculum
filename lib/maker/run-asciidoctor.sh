#!/bin/bash

# last modified 2023-03-07

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

test -f "$ADOC_INPUT" || exit 0

# echo calling asciidoctor in dir $(pwd)

if test -z "$ASCIIDOCTOR_NODE"; then
  asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $(cat $ADOC_INPUT)
else
  NODE_ADOC_INPUT=$ADOC_INPUT-node.js
  echo "let adocFiles = [" > $NODE_ADOC_INPUT
  cat $ADOC_INPUT | sed -e 's/.*/"\0",/' >> $NODE_ADOC_INPUT
  echo "];" >> $NODE_ADOC_INPUT
  echo "module.exports = adocFiles;" >> $NODE_ADOC_INPUT
  #
  node lib/callAdoc.js $NODE_ADOC_INPUT 
fi
