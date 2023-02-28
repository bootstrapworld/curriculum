#!/bin/bash

# last modified 2023-02-28

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

test -f "$ADOC_INPUT" || exit

# echo calling asciidoctor in dir $(pwd)

if test -z "$ASCIIDOCTOR_NODE"; then
  asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $(cat $ADOC_INPUT)
else
  node lib/callAdoc.js $ADOC_INPUT
fi
