#!/bin/bash

# created 2023-01-16
# last modified 2023-02-17

source ${MAKE_DIR}src-subdir-mgt.sh
source ${MAKE_DIR}collect-workbook-pages.sh
# source ${MAKE_DIR}make-workbook-jsons.sh

# echo
# echo doing massage-course $1

d=$1

d=${d%/.}

pathwayName=$(basename $d)

cd $d/..

proglangs=pyret
numpathwayproglangs=1

if test -f $pathwayName/proglang.txt; then
  numpathwayproglangs=$(wc -l $pathwayName/proglang.txt|$SED -e 's/^ *\([^ ]*\).*/\1/')
  # sometimes numlines = 0 bc of lack of ending newline
  test $numpathwayproglangs -eq 0 && numpathwayproglangs=1
  proglangs=$(cat $pathwayName/proglang.txt)
fi

for pl in $proglangs; do
  if test "$pl" = pyret -o $numpathwayproglangs -eq 1; then
    targetpathway=$pathwayName
  else
    targetpathway=$pathwayName-$pl
    mkdir -p $targetpathway
    $CP -upr $pathwayName/* $targetpathway
  fi
  mkdir -p $targetpathway/.cached
  touch $targetpathway/.cached/.proglang-$pl
  adjustproglangsubdirs $targetpathway $pl
  mkdir -p $targetpathway/resources/protected
  mkdir -p $targetpathway/resources/pages
  mkdir -p $targetpathway/workbook
  $CP -p $PROGDIR/.hta* $targetpathway/resources/protected
done

for d in $pathwayName*; do
  test -d $d || continue

  cd $d

  for dd in front-matter back-matter resources; do
    if test -d $dd; then
      cd $dd
      make_solution_pages 
      collect_workbook_pages
      cd ..
    fi
  done

  # collect_workbook_pages
  # make_workbook_jsons

  if test ! -f lesson-order.txt; then
    echo 
    echo WARNING: No lesson-order.txt in pathway $d
  else
    grep -v '^ *;' lesson-order.txt |
      $SED -e 's/\t/ /g' |
      $SED -e 's/;.*//' |
      $SED -e 's/ *$//' |
      grep -v '^ *$' |
      $SED -e 's/^ *\(.*\)/\1/' > .cached/.workbook-lessons.txt.kp
  fi

  echo $d >> $COURSE_INPUT

  cd ..
done

# fixme: weirdly, make fails without the following!
echo -n
