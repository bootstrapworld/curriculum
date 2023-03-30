#!/bin/bash

# last modified 2023-03-29

# echo doing make-books.sh

if test -n "$DEBUGNOBOOK"; then
  echo node lib/makeWorkbook.js for all the courses
else
  #
  for p in distribution/$NATLANG/courses/*; do
    test -d $p || continue
    export COURSE_DIR=$p
    node lib/makeWorkbook.js
  done
  #
fi
