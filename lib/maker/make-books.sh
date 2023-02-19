#!/bin/bash

# lastmod 2023-02-18

# echo doing make-books.sh

for p in distribution/$NATLANG/courses/*; do
  test -d $p || continue
  export COURSE_DIR=$p
  node $TOPDIR/distribution/$NATLANG/lib/makeWorkbook.js
  cd $p/resources/protected
  for f in workbook-sols workbook-long-sols opt-exercises-sols; do
    $CP -p $PROGDIR/redirect.html $f.pdf.html
    $SED -i \
      -e 's/REDIRECT_TARGET_FILE/'$f.pdf'/g' \
      $f.pdf.html
    done
  cd $TOPDIR
done
