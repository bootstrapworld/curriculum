#!/bin/bash

# last modified 2023-02-27

cd $TOPDIR/distribution/$NATLANG

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

test -f "$ADOC_INPUT" || exit

# echo calling asciidoctor in dir $(pwd)

asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $(cat $ADOC_INPUT)
