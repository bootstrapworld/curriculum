#!/bin/bash

for adocfile in $(cat $SETUP_PATHWAY_INDEPENDENT); do

  containingdirectory=$(dirname $adocfile)

  test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

  distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

  adocbasename=$(basename $adocfile)

  ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

  htmlfile=${ascfile%.asc}.html

  solutionsmodearg="#f"

  if echo $adocfile|grep -q '/solution-pages/'; then
    solutionsmodearg="#t"
  fi

  echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\")" >>  $ADOCABLES_INPUT

  echo $ascfile >> $ADOC_INPUT

  echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_PWYINDEP_INPUT

done


for adocfile in $(cat $SETUP_WORKBOOK_PAGE); do
  containingdirectory=$(dirname $adocfile)

  lessondirectory=$(echo $containingdirectory|$SED -e 's#\(.*/lessons/[^/]*\).*#\1#')

  test -f $lessondirectory/.proglang-ignore && continue

  test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

  distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

  adocbasename=$(basename $adocfile)

  ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

  whtmlfile=$containingdirectory/${adocbasename%.adoc}.html

  htmlfile=${ascfile%.asc}.html

  otherdirarg="#f"

  if echo $adocfile|grep -q $OTHERDIRS; then
    otherdirarg="#t"
  fi

  solutionsmodearg="#f"

  if echo $adocfile|grep -q '/solution-pages/'; then
    solutionsmodearg="#t"
  fi

  lesson=$(echo $containingdirectory|$SED -e 's#.*/lessons/\([^/]*\).*#\1#')

  proglangarg="pyret"

  for f in $lessondirectory/.cached/.proglang-*; do
    if test -f $f; then
      proglangarg=$(echo $f|$SED -e 's/.*\.cached\/\.proglang-\(.*\)/\1/')
    fi
  done

  echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:lesson \"$lesson\" #:other-dir $otherdirarg #:solutions-mode? $solutionsmodearg #:proglang \"$proglangarg\")" >>  $ADOCABLES_INPUT

  if test $otherdirarg != "#t" ; then
    echo $ascfile >> $ADOC_INPUT

    echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_WORKBOOKPAGE_INPUT

  fi
done


for adocfile in $(cat $SETUP_LESSON_PLAN); do
  containingdirectory=$(dirname $adocfile)

  test -f $containingdirectory/.proglang-ignore && continue

  distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

  adocbasename=$(basename $adocfile)

  ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

  if test ! -s $adocfile; then
    touch $containingdirectory/.cached/.${adocbasename%.adoc}.asc
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

done



for adocfile in $(cat $SETUP_PATHWAY_RESOURCE); do
  containingdirectory=$(dirname $adocfile)

  test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

  distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

  adocbasename=$(basename $adocfile)

  ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

  htmlfile=${ascfile%.asc}.html

  otherdirarg="#f"

  if echo $adocfile|grep -q $OTHERDIRS; then
    otherdirarg="#t"
  fi

  solutionsmodearg="#f"

  if echo $adocfile|grep -q '/solution-pages/'; then
    solutionsmodearg="#t"
  fi

  resourcesarg="#f"

  if echo $adocfile|grep -q '/resources/'; then
    resourcesarg="#t"
  fi

  targetpathway=$(echo $containingdirectory|$SED -e 's#.*/courses/\([^/]*\).*#\1#')

  proglangarg=

  for proglang in $ALL_PROGLANGS; do
    if test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-$proglang; then
      proglangarg=$proglang
    fi
  done


  echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:other-dir $otherdirarg #:resources $resourcesarg #:target-pathway \"$targetpathway\" #:solutions-mode? $solutionsmodearg #:proglang \"$proglangarg\")" >>  $ADOCABLES_INPUT

  if test $otherdirarg != "#t" ; then
    echo $ascfile >> $ADOC_INPUT

    if test $resourcesarg = "#t" -a $adocbasename = "index.adoc" -a $distrootdir = "../../../"; then
      echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_RESOURCES_INPUT
    else
      echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_WORKBOOKPAGE_INPUT
    fi

  fi
done

for adocfile in $(cat $SETUP_PATHWAY_NARRATIVE); do
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
done
