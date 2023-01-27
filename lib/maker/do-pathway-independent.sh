#!/bin/bash
# created 2023-01-14
# last modified 2023-01-27

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

distrootdir=$(realpath --relative-to=$fcontainingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

whtmlfile=$containingdirectory/${adocbasename%.adoc}.html

htmlfile=${ascfile%.asc}.html

pdffile=${ascfile%.asc}.pdf

otherdirarg="#f"

if $(echo $adocfile|grep -q '/\(fragments\|xtra\|xtras\)/'); then
  otherdirarg="#t"
fi

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\")" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo $htmlfile >> $ADOC_POSTPROC_PWYINDEP_INPUT

echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
