#!/bin/bash

# echo massage-distribution-lesson "$@"

src=$1

d=$2

# echo massage-distribution-lesson src= $src d= $d

superdir=$(echo $src|$SED -e 's#lessons/##'|$SED -e 's#\([^/]*\).*#\1#')

source ${MAKE_DIR}src-subdir-mgt.sh

updatingexistinglesson=

if test -d "$d"; then
  echo Updating existing lesson $d
  updatingexistinglesson=yes
  (cd $d; save_previously_built_solution_pages)
else
  mkdir -p $d
fi

# this is just to avoid problems copying an empty dir
(find $src -maxdepth 0 -empty|grep -q .) || $CP -upr $src/* $d

# ensure lesson plan .adoc present, unless .html or .shtml present
test -f $d/index.adoc ||
  test -f $d/index.html ||
  test -f $d/index.shtml ||
  touch $d/index.adoc

if test ! -d $d/images; then
  mkdir -p $d/images
fi

if test -z "$updatingexistinglesson"; then
  if test ! -d $d/pages; then
    mkdir -p $d/pages
  fi
  if test ! -d $d/pages/.cached; then
    mkdir -p $d/pages/.cached
  fi
  if test ! -f $d/pages/workbook-pages.txt; then
    touch $d/pages/workbook-pages.txt
  fi
fi

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
  alternateproglang=
  lessonNamePl="$lessonName"
  if test "$pl" != pyret -a "$pl" != none; then
    alternateproglang=yes
    lessonNamePl="$lessonName"-$pl
    mkdir -p "$lessonNamePl"
    if test -n "$updatingexistinglesson"; then
      (cd "$lessonNamePl"; save_previously_built_solution_pages)
    fi
  fi
  if test -n "$alternateproglang"; then
    $CP -upr "$lessonName"/* "$lessonNamePl"
  fi
  echo $src > $lessonNamePl/.repodir.txt.kp
  #
  (cd $lessonNamePl; set_up_lesson_dir "$pl" "$firstproglang")
  # echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
  if test -n "$updatingexistinglesson"; then
    (cd $lessonNamePl; check_slide_id slides-$pl.id)
  fi
done

scrubproglangsubdirs $lessonName

if test ! -f $lessonName/.cached/.proglang-pyret -a ! -f $lessonName/.cached/.proglang-none; then
  if test "$USER" = flannery; then
    rm -r $lessonName
  else
    mkdir -p $lessonName/.cached
    touch $lessonName/.proglang-ignore
  fi
fi
