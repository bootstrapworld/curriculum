#!/bin/bash

# last modified 2024-04-29

# echo doing do-pathway-independent $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

# containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $containingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

pdffile=${ascfile%.asc}.pdf

solutionsmodearg="#f"

if echo $adocfile|grep -q '/solution-pages/'; then
  solutionsmodearg="#t"
fi

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\")" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_PWYINDEP_INPUT
