#!/bin/bash 

# created 2023-01-27
# lastmod 2023-01-28

source ${MAKE_DIR}make-workbook-jsons.sh

cd $TOPDIR/distribution/$NATLANG/courses

for p in *; do
  test -d $p || continue
  export TGTPATHWAY=$p
  cd $p
  make_workbook_jsons
  node $TOPDIR/distribution/$NATLANG/lib/makeWorkbook.js
  cd resources/protected
  for f in workbook-sols workbook-long-sols opt-exercises-sols; do
    $CP -p $PROGDIR/redirect.html $f.pdf.html
    $SED -i \
      -e 's/REDIRECT_TARGET_FILE/'$f.pdf'/g' \
      $f.pdf.html
    done
  cd ..
done
