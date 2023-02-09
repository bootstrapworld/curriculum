#!/bin/bash

# created 2023-01-14
# last modified 2023-02-09

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

distrootdir=$(realpath --relative-to=$fcontainingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

if test ! -s $adocfile; then
  touch $fcontainingdirectory/.cached/.${adocbasename%.adoc}.asc
  exit
fi

htmlfile=${ascfile%.asc}.html

whtmlfile=$containingdirectory/${adocbasename%.adoc}.shtml

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

lesson=$(echo $containingdirectory|$SED -e 's#lessons/\([^/]*\).*#\1#')

proglangarg="pyret"

if $(echo $lesson|grep -q '\-codap$'); then proglangarg=codap
elif $(echo $lesson|grep -q '\-none$'); then proglangarg=none
elif $(echo $lesson|grep -q '\-spreadsheets$'); then proglangarg=spreadsheets
elif $(echo $lesson|grep -q '\-spreadsheets$'); then proglangarg=spreadsheets
elif $(echo $lesson|grep -q '\-wescheme$'); then proglangarg=wescheme
fi

otherproglangs="#f"

proglangfile=${adocfile%/*}/proglang.txt

if test -f "$proglangfile"; then
  if grep -q codap $proglangfile; then otherproglangs="$otherproglangs \"codap\""; fi
  if grep -q none $proglangfile; then otherproglangs="$otherproglangs \"none\""; fi
  if grep -q pyret $proglangfile; then otherproglangs="$otherproglangs \"pyret\""; fi
  if grep -q spreadsheets $proglangfile; then otherproglangs="$otherproglangs \"spreadsheets\""; fi
  if grep -q wescheme $proglangfile; then otherproglangs="$otherproglangs \"wescheme\""; fi
fi

# touch $fcontainingdirectory/.cached/.index-sidebar.asc
touch $fcontainingdirectory/.cached/.index-standards.asc

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:lesson-plan \"$lesson\" #:proglang \"$proglangarg\" #:other-proglangs '($otherproglangs))" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo $htmlfile >> $ADOC_POSTPROC_LESSONPLAN_INPUT

echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"portrait\" }" >> $PUPPETEER_INPUT
