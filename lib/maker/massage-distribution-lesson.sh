#!/bin/bash

# created 2023-01-14
# last modified 2023-02-17

source ${MAKE_DIR}src-subdir-mgt.sh
source ${MAKE_DIR}collect-workbook-pages.sh

# echo doing massage-distribution-lesson $1

d=$1

d=${d%/.}

lessonName=$(basename $d)

cd $d

proglangs=pyret
firstproglang=pyret

if test -f proglang.txt; then
  proglangs=$(cat proglang.txt)
  firstproglang=$(echo $proglangs|$SED -e 's/^\([^ ]\+\).*/\1/')
fi

cd ..

lessonNamePl=
for pl in $proglangs; do
  lessonNamePl="$lessonName"
  if test "$pl" != pyret; then
    lessonNamePl="$lessonName"-$pl
    mkdir -p "$lessonNamePl"
    cp -upr "$lessonName"/* "$lessonNamePl"
  fi
  #
  cd "$lessonNamePl"
  mkdir -p .cached
  touch .cached/.proglang-$pl
  touch .cached/.redo
  test "$firstproglang" = $pl && touch .cached/.primarylesson
  test  -d pages || mkdir pages
  test -d pages/.cached || mkdir -p pages/.cached

  # echo calling collect workbook pgs
  collect_workbook_pages .
  # echo calling collect exercises
  $PROGDIR/collect-exercises.rkt index.adoc $pl
  exer_list_file=pages/.cached/.exercise-pages-ls.txt.kp
  if test -f $exer_list_file; then
    exer_aspect_list_file=pages/.cached/.exercise-pages.txt.kp
    rm -f $exer_aspect_list_file
    for f in $(cat $exer_list_file); do
      if test ${f%.adoc} = $f; then
        echo $f >> $exer_aspect_list_file
      elif test ! -f pages/$f; then
        echo
        echo WARNING: Exercise file pages/$f not found
      elif head -5 pages/$f|grep -q '^ *\[\.landscape\] *$'; then
        echo $f landscape >> $exer_aspect_list_file
      else
        echo $f >> $exer_aspect_list_file
      fi
    done
  fi

  for subdir in *; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done
  #
  make_solution_pages 
  cd ..
  echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
done

if test ! -f $lessonName/.cached/.proglang-pyret; then
  mkdir -p $lessonName/.cached
  touch $lessonName/.proglang-ignore
fi
