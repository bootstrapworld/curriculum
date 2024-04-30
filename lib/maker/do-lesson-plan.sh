#!/bin/bash

# echo doing do-lesson-plan.sh $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

test -f $containingdirectory/.proglang-ignore && exit

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

if test ! -s $adocfile; then
  touch $containingdirectory/.cached/.${adocbasename%.adoc}.asc
  # exit
fi

htmlfile=${ascfile%.asc}.html

solutionsmodearg="#f"

if echo $adocfile|grep -q '/solution-pages/'; then
  solutionsmodearg="#t"
fi

lesson=$(echo $containingdirectory|$SED -e 's#.*/lessons/\([^/]*\).*#\1#')

proglangarg="pyret"

for f in $containingdirectory/.cached/.proglang-*; do
  if test -f $f; then
    proglangarg=$(echo $f|$SED -e 's/.*\.cached\/\.proglang-\(.*\)/\1/')
  fi
done

otherproglangs="#f"

proglangfile=${adocfile%/*}/proglang.txt

if test -f "$proglangfile"; then
  for proglang in $ALL_PROGLANGS; do
    if grep -q $proglang $proglangfile; then
      otherproglangs="$otherproglangs \"$proglang\""
    fi
  done
fi

touch $containingdirectory/.cached/.index-standards.asc

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:lesson-plan \"$lesson\" #:proglang \"$proglangarg\" #:other-proglangs '($otherproglangs))" >>  $ADOCABLES_INPUT

echo $ascfile >> $ADOC_INPUT

echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_LESSONPLAN_INPUT

