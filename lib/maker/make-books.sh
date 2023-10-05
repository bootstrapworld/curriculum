#!/bin/bash

# start=`date +%s`

if test -n "$DEBUGNOBOOK"; then
  echo node lib/makeWorkbook.js for all the courses
else
  #
  for p in distribution/$NATLANG/courses/*; do
    test -d $p || continue
    COURSE_DIR=$p node lib/makeWorkbook.js &
    # COURSE_DIR=$p node lib/makeWorkbook.js
  done
  wait
  #
fi

# end=`date +%s`
# runtime=$((end - start))
# echo make-books took $runtime s
