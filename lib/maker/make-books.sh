#!/bin/bash

# start=`date +%s`

if test -n "$DEBUGNOBOOK"; then
  echo node lib/makeWorkbook\-node.js for all the courses

elif test -n "$COURSE"; then
  for c in $(echo $COURSE|$SED -e 's/,/ /g'); do
    p=distribution/$NATLANG/courses/$c
    test -d $p || continue
    COURSE_DIR=$p node lib/makeWorkbook-node.js &
  done
  wait

else
  #
  for p in distribution/$NATLANG/courses/*; do
    test -d $p || continue
    mp=$p/.cached/.missing-workbook-pages
    if test -f $mp; then
      echo Not making workbooks for $p as it\'s missing the following workbook pages:
      for f in $(cat $mp); do
        echo - $f
      done
      continue
    fi
    COURSE_DIR=$p node lib/makeWorkbook-node.js &
    # COURSE_DIR=$p node lib/makeWorkbook.js
  done
  wait
  #
fi

# end=`date +%s`
# runtime=$((end - start))
# echo make-books took $runtime s
