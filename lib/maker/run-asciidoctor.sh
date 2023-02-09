#!/bin/bash

# created 2023-01-19
# last modified 2023-02-09

cd $TOPDIR/distribution/$NATLANG

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

rm -f .cached/.do-asciidoctor.js-split*

tmpf=.cached/.do-asciidoctor.js

test -f "$tmpf" || exit

split -l 100 $tmpf $tmpf-split

# echo calling asciidoctor in dir $(pwd)

for f in $tmpf-split*; do
  asciidoctor -a linkcss -a stylesheet=$TOPDIR/distribution/$NATLANG/lib/curriculum.css -a cachedir=.cached/ -B . $(cat $f)
done
