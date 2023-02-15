#!/bin/bash

# created 2023-02-13
# last modifed 1111-11-11

cd distribution/$NATLANG/lessons

rm -f $RELEVANT_LESSONS_INPUT

for lsn in *; do
  # echo collect relevant lessons from $lsn
  test -d "$lsn" || continue
  test -f "$lsn"/.proglang-ignore && continue
  echo $lsn >> $RELEVANT_LESSONS_INPUT
done
