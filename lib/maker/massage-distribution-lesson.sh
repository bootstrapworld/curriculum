#!/bin/bash

# last modified 2023-03-04

src=$1

d=$2

d=${d%/.}

mkdir -p $d/.cached

source ${MAKE_DIR}dir-checksum.sh

dir_hasnt_changed $src $d/.cached/.checksum.md5txt && exit 0

# echo doing massage-distribution-lesson "$@"

(find $src -maxdepth 0 -empty|grep -q .) || $CP -upr $src/* $d

test ! -f $d/index.adoc && touch $d/index.adoc

source ${MAKE_DIR}src-subdir-mgt.sh

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
  if test "$pl" != pyret -a "$pl" != none; then
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
  test -d pages || mkdir pages
  test -d pages/.cached || mkdir -p pages/.cached

  # echo calling collect workbook pgs
  $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
  # echo calling collect exercises
  echo "  " { \"$lessonNamePl\", \"$pl\" }, >> $EXERCISE_COLLECTOR_INPUT

  for subdir in *; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done
  #
  make_solution_pages
  cd ..
  # echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
done

if test ! -f $lessonName/.cached/.proglang-pyret -a ! -f $lessonName/.cached/.proglang-none; then
  mkdir -p $lessonName/.cached
  touch $lessonName/.proglang-ignore
fi
