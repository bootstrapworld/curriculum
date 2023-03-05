#!/bin/bash

# last modified 2023-03-02

# echo doing make-books.sh

if test -n "$DEBUGNOBOOK"; then
  echo node lib/makeWorkbook.js for all the courses
else
  #
  for p in distribution/$NATLANG/courses/*; do
    test -d $p || continue
    export COURSE_DIR=$p
    node lib/makeWorkbook.js
    cd $p/resources/protected
    for f in workbook-sols workbook-long-sols opt-exercises-sols; do
      $CP -p $TOPDIR/lib/redirect.html $f.pdf.html
      $SED -i \
        -e 's/REDIRECT_TARGET_FILE/'$f.pdf'/g' \
        $f.pdf.html
      done
      cd $TOPDIR
    done
    #
fi
