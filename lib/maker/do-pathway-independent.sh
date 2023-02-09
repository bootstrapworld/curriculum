#!/bin/bash

# created 2023-01-14
# last modified 2023-02-09

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

test -d $fcontainingdirectory/.cached || mkdir -p $fcontainingdirectory/.cached

distrootdir=$(realpath --relative-to=$fcontainingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

whtmlfile=$containingdirectory/${adocbasename%.adoc}.html

htmlfile=${ascfile%.asc}.html

pdffile=${ascfile%.asc}.pdf

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\")" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo $htmlfile >> $ADOC_POSTPROC_PWYINDEP_INPUT

echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
