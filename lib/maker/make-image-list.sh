#!/bin/bash

# last modified 2023-02-22

cd $TOPDIR/distribution/$NATLANG/lessons

echo return { > $IMAGE_LIST_FILE
for L in *; do
  Lbasename=$L

  if test $(echo $L|grep "\-wescheme"); then
    Lbasename=${L%-wescheme}
  fi

  if ! grep -q "^ *\"$Lbasename/images/" $IMAGE_LIST_FILE; then
    if test -f $L/images/lesson-images.json; then
      echo "  " { \"$Lbasename\",  \"$L/images/lesson-images.json\" }, >> $IMAGE_LIST_FILE
    fi
  fi
done
echo } >> $IMAGE_LIST_FILE
$TOPDIR/${MAKE_DIR}make-images-js.lua
