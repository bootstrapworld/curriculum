#!/bin/bash

# created 2023-01-14
# last modified 2023-01-20

CP=cp
SED=sed

source ${MAKE_DIR}src-subdir-mgt.sh

# echo
# echo doing massage-distribution-lesson $1

d=$1

d=${d%/.}

lessonName=$(basename $d)

cd $d

proglangs=pyret
firstproglang=pyret

if test -f proglang.txt; then
  proglangs=$(cat proglang.txt)
  firstproglang=$(echo $proglangs|sed -e 's/^\([^ ]\+\).*/\1/')
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
  if test "$firstproglang" = $pl; then
    touch .cached/.primarylesson
  fi
  if test ! -d pages; then
    mkdir pages
  fi
  if test ! -f pages/workbook-pages.txt; then
    touch pages/workbook-pages.txt
  fi
  test -d pages/.cached || mkdir -p pages/.cached

  #ensure workbook-pages.txt ends in newline, or while isn't happy
  $SED -i -e '$a\' pages/workbook-pages.txt

  rm -f pages/.cached/.workbook-{pages,pages-ls,notes-pages-ls}.txt.kp

  # it should exist, even if empty
  touch pages/.cached/.workbook-pages-ls.txt.kp

  while read -r f; do
    # echo finding aspect of "$f"
    aspect=portrait
    g=$f
    if echo "$f"|grep -q '^ *;'; then
      :
    elif echo "$f"|grep -q '^ *//'; then
      :
    elif echo "$f"|grep -q landscape; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> pages/.cached/.workbook-pages-ls.txt.kp
      aspect=landscape
    elif echo "$f"|grep -q portrait; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> pages/.cached/.workbook-pages-ls.txt.kp
    elif test "${f%.adoc}" = "$f"; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
    else
      if test -f "$f" && head -n 5 "$f"|grep -q '^ *\[\.landscape\] *$'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      elif test -f "$g" && head -n 60 "$g"|grep -q 'body.*landscape'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      else
        echo $f >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
      fi
    fi
  done < pages/workbook-pages.txt

  for subdir in *; do
    if test -d "$subdir"; then
      adjustproglangsubdirs "$subdir" "$pl"
    fi
  done
  #
  make_solution_pages .
  cd ..
  echo "$lessonNamePl" >> $RELEVANT_LESSONS_INPUT
done
