#!/bin/bash

# created 2023-02-13
# last modifed 1111-11-11

cd distribution/$NATLANG/lessons

rm -f $RELEVANT_LESSONS_INPUT

for lsn in *; do
  test -d "$lsn" || continue
  echo $lsn >> $RELEVANT_LESSONS_INPUT
done
