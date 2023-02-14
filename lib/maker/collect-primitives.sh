#!/bin/bash

# created 2023-01-19
# last modified 2023-02-13

cd distribution/$NATLANG/lessons

for lsn in *; do
  test -d "$lsn" || continue
  copacetic=1
  for f in $lsn/.cached/.*primtxt; do
    test -f $f || copacetic=
  done
  if test -n "$copacetic"; then
    cat $lsn/.cached/.*primtxt | sort -u > $lsn/.cached/.index-primitives.txt.kp
  fi
done
