#!/bin/bash
# created 2023-01-14
# last modified 2023-01-28

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

distrootdir=$(realpath --relative-to=$fcontainingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

targetpathway=$(echo $containingdirectory|$SED -e 's#courses/\([^/]*\).*#\1#')

# proglangarg=pyret
if test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-codap; then proglangarg=codap
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-none; then proglangarg=none
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-spreadsheets; then proglangarg=spreadsheets
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-wescheme; then proglangarg=wescheme
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-pyret; then proglangarg=pyret
fi

otherproglangs="#f"

if test "$targetpathway" = "algebra-wescheme"; then
  otherproglangs="$otherproglangs \"pyret\""
elif test "$targetpathway" = "algebra-pyret"; then
  otherproglangs="$otherproglangs \"wescheme\""
elif test "$targetpathway" = "data-science" -o "$targetpathway" = "data-science-codap"; then
  otherproglangs="$otherproglangs \"codap\""
fi

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:narrative #t #:target-pathway \"$targetpathway\" #:proglang \"$proglangarg\" #:other-proglangs '($otherproglangs))" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo $htmlfile >> $ADOC_POSTPROC_NARRATIVE_INPUT

echo courses/$targetpathway/.cached/.pathway-glossary.asc >> $ADOC_INPUT

echo courses/$targetpathway/.cached/.pathway-glossary.html >> $ADOC_POSTPROC_NARRATIVEAUX_INPUT
