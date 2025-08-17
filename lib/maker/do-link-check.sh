#! /usr/bin/env bash

# last modified 2025-07-11

find distribution/$NATLANG/{lessons,courses} -type f \
  -name \.\*internal-links.txt.kp |
  xargs $TOPDIR/lib/maker/check-internal-links.lua

if test -f distribution/$NATLANG/.cached/.check-internal-links; then
  echo 👎 Broken internal links found
else
  echo 👍 No broken internal links found
fi

rm -f distribution/$NATLANG/.cached/.check-external-links

find distribution/$NATLANG/{lessons,courses} -type f \
  -name \.\*external-links.txt.kp |
  xargs $TOPDIR/lib/maker/check-external-links.sh

if test -f distribution/$NATLANG/.cached/.check-external-links; then
  echo 👎 Broken external links found
else
  echo 👍 No broken external links found
fi
