#! /usr/bin/env bash

# echo massage-course.sh "$@"

src=$1

d=$2

if test -d "$d"; then
  echo Updating existing course $d
else
  mkdir -p $d
fi

(find $src -maxdepth 0 -empty|grep -q .) || $CP -upr $src/* $d

# ensure pathway narrative adoc always present, even if present
test ! -f $d/index.adoc && touch $d/index.adoc

source ${MAKE_DIR}src-subdir-mgt.sh

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
  echo $pl > $targetpathway/.cached/.record-proglang
  adjustproglangsubdirs $targetpathway $pl
  mkdir -p $targetpathway/resources/protected
  mkdir -p $targetpathway/resources/pages
  mkdir -p $targetpathway/workbook
  $CP -p $TOPDIR/lib/.hta* $targetpathway/resources/protected

  cd $targetpathway

  for dd in front-matter back-matter resources; do
    if test -d $dd; then
      cd $dd
      mkdir -p .cached
      if test -d pages; then
        # mkdir -p .cached
        make_solution_pages
        $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
      fi
      cd ..
    fi
  done

  if test ! -f lesson-order.txt; then
    echo WARNING: No lesson-order.txt in pathway $targetpathway
    touch lesson-order.txt
    touch .cached/.workbook-lessons.txt.kp
  else
    grep -v '^ *;' lesson-order.txt |
      $SED -e 's/\t/ /g' |
      $SED -e 's/;.*//' |
      $SED -e 's/ *$//' |
      grep -v '^ *$' |
      $SED -e 's/^ *\(.*\)/\1/' > .cached/.workbook-lessons.txt.kp
    if test "$pl" != pyret -a "$pl" != none; then
      $SED -i -e 's/.*/\0-'$pl'/' .cached/.workbook-lessons.txt.kp
    fi
  fi

  cd ..

done

scrubproglangsubdirs $pathwayName

# fixme: weirdly, make fails without the following!
echo -n
