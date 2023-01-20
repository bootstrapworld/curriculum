#!/bin/bash
# created 2023-01-14
# last modified 2023-01-20

adocfile=$1

containingdirectory=$(dirname $adocfile)

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $containingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

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
