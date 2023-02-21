#!/bin/bash

# created 2023-01-20
# last modified 2023-02-21

cd $TOPDIR/distribution/$NATLANG/lessons
export DISTROOTDIR=../

echo "(" > $IMAGE_LIST_FILE
first=1
for L in *; do
  Lbasename=$L

  if test $(echo $L|grep "\-wescheme"); then
    Lbasename=${L%-wescheme}
  fi

  if ! grep -q "^ *\"$Lbasename/images/" $IMAGE_LIST_FILE; then
    if test -f $L/images/lesson-images.json; then
      echo \(\"$Lbasename\" \"$L/images/lesson-images.json\"\) >> $IMAGE_LIST_FILE
    fi
  fi
done
echo ")" >> $IMAGE_LIST_FILE
$PROGDIR/make-images-js.rkt
