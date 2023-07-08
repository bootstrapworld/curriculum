#!/bin/bash

# echo massage-distribution-lesson "$@"

src=$1

d=$2

source ${MAKE_DIR}src-subdir-mgt.sh

if test  -d "$d"; then
  echo Updating existing lesson $d
  (cd $d; save_old_solution_pages)
else
  mkdir -p $d
fi

# this is just to avoid problems copying an empty dir
(find $src -maxdepth 0 -empty|grep -q .) || $CP -upr $src/* $d

# ensure lesson plan adoc always present, even if empty
test ! -f $d/index.adoc && touch $d/index.adoc

echo $src > $d/.repodir.txt.kp

source ${MAKE_DIR}src-subdir-mgt.sh

lessonName=$(basename $d)

cd $d/..

proglangs=pyret
firstproglang=pyret

if test -f $lessonName/proglang.txt; then
  proglangs=$(cat $lessonName/proglang.txt)
  firstproglang=$(echo $proglangs|$SED -e 's/^\([^ ]\+\).*/\1/')
fi

lessonNamePl=
for pl in $proglangs; do
  lessonNamePl="$lessonName"
  if test "$pl" != pyret -a "$pl" != none; then
    lessonNamePl="$lessonName"-$pl
    mkdir -p "$lessonNamePl"
    $CP -upr "$lessonName"/* "$lessonNamePl"
    $CP -p "$lessonName"/.repodir.txt.kp "$lessonNamePl"
  fi
  #
  cd "$lessonNamePl"
  mkdir -p .cached
  touch .cached/.proglang-$pl
  echo $pl > .cached/.record-proglang
  touch .cached/.redo
  test "$firstproglang" = $pl && touch .cached/.primarylesson
  test -d pages || mkdir pages

  for subdir in *; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done
  #
  make_solution_pages

  # echo calling collect-work-pages.lua in $(pwd)
  $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
  cd ..
  # echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
done

scrubproglangsubdirs $lessonName

if test ! -f $lessonName/.cached/.proglang-pyret -a ! -f $lessonName/.cached/.proglang-none; then
  mkdir -p $lessonName/.cached
  touch $lessonName/.proglang-ignore
fi
