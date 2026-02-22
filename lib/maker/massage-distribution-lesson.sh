#! /usr/bin/env bash

# echo massage-distribution-lesson "$@"

src=$1

d=$2

# echo massage-distribution-lesson src= $src d= $d

superdir=$(echo $src|$SED -e 's#lessons/##'|$SED -e 's#\([^/]*\).*#\1#')

source ${MAKE_DIR}src-subdir-mgt.sh

updatingexistinglesson=

if test -d "$d"; then
  echo "  " • Updating existing lesson $d
  updatingexistinglesson=yes
  srcdate=$(dir_timestamp $src)
  tgtdate=$(dir_timestamp $d)
  deletepdfs=
  if test $srcdate -gt $tgtdate; then
    rm -fr $d
    mkdir -p $d
  else
    updatingexistinglesson=yes
    (cd $d; save_previously_built_solution_pages)
  fi
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

test -d $d/images || mkdir -p $d/images

if test -z "$updatingexistinglesson"; then
  test -d $d/pages || mkdir -p $d/pages
  test -d $d/pages/.cached || mkdir -p $d/pages/.cached
  test -f $d/pages/workbook-pages.txt || touch $d/pages/workbook-pages.txt
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
  # is special treatment for Flannery still needed?
  if test "$USER" = flannery; then
    rm -r $lessonName
  else
    mkdir -p $lessonName/.cached
    touch $lessonName/.proglang-ignore
  fi
fi
