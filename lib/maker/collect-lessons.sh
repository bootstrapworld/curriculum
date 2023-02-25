#!/bin/bash

# last modified 2023-02-25

# echo doing collect-lessons.sh

cd $TOPDIR/distribution/$NATLANG/lessons

echo return { > $LESSONS_LIST_FILE

for L in *; do

  test -d $L || continue

  if echo $L|grep -q "\-wescheme"; then :
  else
    echo " " \"$L\", >> $LESSONS_LIST_FILE
  fi

done

echo } >> $LESSONS_LIST_FILE
