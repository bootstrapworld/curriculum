#! /usr/bin/env bash

lib_dir=$TOPDIR/distribution/$NATLANG/lib
self_guided_dir=$lib_dir/self-guided

function create_local_self_guided() {
  local g=$1
  test -f $g/selfGuidedBits.jsx || return
  (cd $g
  mkdir -p self-guided
  cd self-guided
  ln -sf $lib_dir/curriculum.css
  for sgf in $(ls $self_guided_dir); do
    # soft link to node_modules subdir from the generic dir;
    # other files copied
    if test -d $self_guided_dir/$sgf; then
      ln -sf $self_guided_dir/$sgf
    else
      cp -p $self_guided_dir/$sgf .
    fi
  done
  ln -sf ../selfGuidedBits.jsx
  test -d ../images && ln -sf ../images
  test -d ../videos && ln -sf ../videos
  )
}

if test -s $RELEVANT_LESSONS_LIST_FILE; then
  # if make called with COURSE= only create self-guided dirs for the relevant lessons
  for f in $(cat $RELEVANT_LESSONS_LIST_FILE); do
    g=$TOPDIR/distribution/$NATLANG/lessons/$f
    create_local_self_guided $g
  done
else
  # create self-guided dirs for all lessons
  for f in $(ls $TOPDIR/distribution/$NATLANG/lessons); do
    g=$TOPDIR/distribution/$NATLANG/lessons/${f%/}
    create_local_self_guided $g
  done
fi

# keep make happy with explicit exit 0
exit 0
