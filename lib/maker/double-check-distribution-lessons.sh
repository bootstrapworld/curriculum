#! /usr/bin/env bash

# echo doing double-check-distribution-lesson.sh in $(pwd)

source ${MAKE_DIR}src-subdir-mgt.sh

cd distribution/$NATLANG/lessons

for lessonName in *; do
  test -d $lessonName || continue
  test -f $lessonName/.cached/.proglang-pyret || continue
  proglangfile=$lessonName/proglang.txt
  test -f $proglangfile || continue
  test $(wc -l $proglangfile | cut -d" " -f1) -gt 1 || continue
  # echo checking $lessonName
  proglangs=$(cat $proglangfile)
  firstproglang=$(echo $proglangs|$SED -e 's/^\([^ ]\+\).*/\1/')
  lessonNamePl=
  for pl in $proglangs; do
    test "$pl" = pyret -o "$pl" = none && continue
    lessonNamePl="$lessonName"-$pl
    test -d "$lessonNamePl" && continue
    echo re-added lesson $lessonNamePl
    mkdir -p "$lessonNamePl"
    $CP -upr "$lessonName"/* "$lessonNamePl"
    $CP -p "$lessonName"/.repodir.txt.kp "$lessonNamePl"
    (cd $lessonNamePl; set_up_lesson_dir "$pl" "$firstproglang")
  done
done
