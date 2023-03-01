#!/bin/bash

# last modified 2023-03-01

for yyternal in internal external; do

  rm -fr distribution/$NATLANG/.cached/.check-$yyternal-links

  find distribution/$NATLANG/{lessons,courses} -type f \
    -name \.\*$yyternal-links.txt.kp |
    xargs $TOPDIR/lib/check-$yyternal-links.sh

done

for yyternal in internal external; do

  if test -f distribution/$NATLANG/.cached/.check-$yyternal-links; then
    echo 👎 Broken $yyternal links found
  else
    echo 👍 No broken $yyternal links found
  fi

done
