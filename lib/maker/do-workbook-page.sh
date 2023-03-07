#!/bin/bash

# last modified 2023-03-07

# echo doing do-workbook-page.sh $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

lessondirectory=$(echo $containingdirectory|$SED -e 's#\(.*/lessons/[^/]*\).*#\1#')

test -f $lessondirectory/.proglang-ignore && exit

test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

whtmlfile=$containingdirectory/${adocbasename%.adoc}.html

htmlfile=${ascfile%.asc}.html

otherdirarg="#f"

if $(echo $adocfile|grep -q '/\(fragments\|xtra\|xtras\)/'); then
  otherdirarg="#t"
fi

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

lesson=$(echo $containingdirectory|$SED -e 's#.*/lessons/\([^/]*\).*#\1#')

proglangarg="pyret"

if $(echo $lesson|grep -q '\-wescheme$'); then
  proglangarg=wescheme
elif $(echo $lesson|grep -q '\-codap$'); then
  proglangarg=codap
elif $(echo $lesson|grep -q '\-none$'); then
  proglangarg=none
elif $(echo $lesson|grep -q '\-spreadsheets$'); then
  proglangarg=spreadsheets
fi

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:lesson \"$lesson\" #:other-dir $otherdirarg #:solutions-mode? $solutionsmodearg #:proglang \"$proglangarg\")" >>  $ADOCABLES_INPUT

if test $otherdirarg != "#t" ; then
  echo $ascfile >> $ADOC_INPUT

  echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_WORKBOOKPAGE_INPUT

fi
