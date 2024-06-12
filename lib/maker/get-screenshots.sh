#!/bin/bash

for lesson in distribution/$NATLANG/lessons/*; do 
  test -f $lesson/index.shtml || continue
  LESSON=${lesson##*/} node lib/maker/screenshot-elts.js distribution
done
