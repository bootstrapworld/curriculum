#!/bin/bash

# created 2023-01-20
# last modified 2023-02-09

cd $TOPDIR/distribution/$NATLANG/lessons
export DISTROOTDIR=../
IMAGEFILES=$TOPDIR/distribution/$NATLANG/.cached/.image-files.rkt
IMAGEFILE=$TOPDIR/distribution/$NATLANG/images.js

echo "(" > $IMAGEFILES
first=1
for L in *; do
  Lbasename=$L

  if test $(echo $L|grep "\-wescheme"); then
    Lbasename=${L%-wescheme}
  fi

  if ! grep -q "^ *\"$Lbasename/images/" $IMAGEFILES; then
    if test -f $L/images/lesson-images.json; then
      echo \(\"$Lbasename\" \"$L/images/lesson-images.json\"\) >> $IMAGEFILES
    fi
  fi
done
echo ")" >> $IMAGEFILES
$PROGDIR/make-images-js.rkt
