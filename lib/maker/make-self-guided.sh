#! /usr/bin/env bash

# Usage: make-self-guided.sh <lesson_dir>
#
# Sets up <lesson_dir>/self-guided/ for a single lesson by copying
# (or symlinking) the contents of $TOPDIR/distribution/$NATLANG/lib/self-guided/
# and moving the lesson's freshly-extracted selfGuidedBits.jsx into place.
#
# Skips lessons that don't have a selfGuidedBits.jsx (i.e. lessons where
# extract_self_guided wasn't invoked). The one-time setup of
# self-guided/node_modules is handled by the Makefile.

g=$1
test -f "$g/selfGuidedBits.jsx" || exit 0

self_guided_dir=$TOPDIR/distribution/$NATLANG/lib/self-guided

mkdir -p "$g/self-guided"
cd "$g/self-guided" || exit 1

for sgf in "$self_guided_dir"/*; do
  test -e "$sgf" || continue
  if test -d "$sgf"; then
    ln -sf "$sgf"
  else
    cp -p "$sgf" .
  fi
done

mv ../selfGuidedBits.jsx .
test -d ../images && ln -sf ../images
test -d ../videos && ln -sf ../videos

exit 0
