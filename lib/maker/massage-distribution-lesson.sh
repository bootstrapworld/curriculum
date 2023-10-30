#!/bin/bash

# echo massage-distribution-lesson "$@"

src=$1

d=$2

superdir=$(echo $src|sed -e 's#lessons/##'|sed -e 's#\([^/]*\).*#\1#')

source ${MAKE_DIR}src-subdir-mgt.sh

if test  -d "$d"; then
  echo Updating existing lesson $d
  (cd $d; save_old_solution_pages)
else
  mkdir -p $d
fi

# this is just to avoid problems copying an empty dir
(find $src -maxdepth 0 -empty|grep -q .) || $CP -upr $src/* $d

# ensure lesson plan .adoc present, unless .shtml present
if test ! -f $d/index.adoc; then
  if test ! -f $d/index.shtml; then
    touch $d/index.adoc
  fi
fi

echo $src > $d/.repodir.txt.kp

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
  set_up_lesson_dir "$lessonNamePl" "$pl" "$firstproglang"
  # echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
done

scrubproglangsubdirs $lessonName

if test ! -f $lessonName/.cached/.proglang-pyret -a ! -f $lessonName/.cached/.proglang-none; then
  mkdir -p $lessonName/.cached
  touch $lessonName/.proglang-ignore
fi
