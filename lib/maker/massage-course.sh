#!/bin/bash

# created 2023-01-16
# last modified 2023-01-20

source ${MAKE_DIR}src-subdir-mgt.sh
source ${MAKE_DIR}collect-workbook-pages.sh
source ${MAKE_DIR}make-workbook-jsons.sh

# echo
# echo doing massage-course $1

d=$1

d=${d%/.}

pathwayName=$(basename $d)

cd $d/..

proglangs=pyret
firstproglang=pyret
numpathwayproglangs=1

if test -f $pathwayName/proglang.txt; then
  numpathwayproglangs=$(wc -l $pathwayName/proglang.txt|$SED -e 's/^ *\([^ ]*\).*/\1/')
  proglangs=$(cat $pathwayName/proglang.txt)
  firstproglang=$(echo $proglangs|$SED -e 's/^\([^ ]\+\).*/\1/')
  if test $numpathwayproglangs -eq 0; then
    numpathwayproglangs=1
  fi
fi

if test $numpathwayproglangs -eq 1; then
  mkdir -p $pathwayName/.cached
  touch $pathwayName/.cached/.proglang-$firstproglang
else
  for pl in $proglangs; do
    if test "$pl" = pyret; then
      targetpathway=$pathwayName
    else
      targetpathway=$pathwayName-$pl
      mkdir -p $targetpathway
      $CP -upr $pathwayName/* $targetpathway
    fi
    mkdir -p $targetpathway/.cached
    touch $targetpathway/.cached/.proglang-$pl
    adjustproglangsubdirs $targetpathway $pl
  done
fi

for d in $pathwayName*; do
  if test -d $d; then
    cd $d
    for dd in front-matter back-matter resources; do
      if test -d $dd; then
        make_solution_pages $dd
        collect_workbook_pages $dd
      fi
    done
    $PROGDIR/collect-workbook-pages.rkt
    make_workbook_jsons
    cd ..
  fi
done

# weird, make fails without following!
echo -n
