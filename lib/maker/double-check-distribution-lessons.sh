#!/bin/bash

# echo doing double-check-distribution-lesson.sh in $(pwd)

source ${MAKE_DIR}src-subdir-mgt.sh

cd distribution/$NATLANG/lessons

for lessonName in *; do
  # echo checking $lessonName
  test -d $lessonName || continue
  test -f $lessonName/.cached/.proglang-pyret || continue
  test -f $lessonName/proglang.txt || continue
  proglangs=$(cat $lessonName/proglang.txt)
  firstproglang=$(echo $proglangs|$SED -e 's/^\([^ ]\+\).*/\1/')
  lessonNamePl=
  for pl in $proglangs; do
    test "$pl" = pyret && continue
    test "$pl" = none && continue
    lessonNamePl="$lessonName"-$pl
    test -d "$lessonNamePl" && continue
    echo re-added lesson $lessonNamePl
    mkdir -p "$lessonNamePl"
    $CP -upr "$lessonName"/* "$lessonNamePl"
    $CP -p "$lessonName"/.repodir.txt.kp "$lessonNamePl"
    set_up_lesson_dir "$lessonNamePl" "$pl" "$firstproglang"
  done
done
