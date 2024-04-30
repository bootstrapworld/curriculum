#!/bin/bash

# last modified 2024-04-29

# echo do-pathway-narrative $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

solutionsmodearg="#f"

if echo $adocfile|grep -q '/solution-pages/'; then
  solutionsmodearg="#t"
fi

targetpathway=$(echo $containingdirectory|$SED -e 's#.*/courses/\([^/]*\).*#\1#')

proglangarg=

for proglang in $ALL_PROGLANGS; do
  if test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-$proglang; then
    proglangarg=$proglang
  fi
done

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

echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_NARRATIVE_INPUT
