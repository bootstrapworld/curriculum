#! /usr/bin/env bash

function adjustproglangsubdirs() {
  # echo adjustproglangsubdirs "$@" in $(pwd)
  local d=$1
  local pl=$2

  if test -d "$d"/"$pl"; then
    (find "$d"/"$pl" -maxdepth 0 -empty|grep -q .) || $CP -p "$d"/"$pl"/* "$d"
  fi

  if test "$pl" != pyret -a "$pl" != none; then
    local lang
    for lang in $ALL_PROGLANGS; do
      test -d "$d"/$lang && rm -fr "$d"/$lang
    done
  fi

  local subdir
  for subdir in "$d"/*; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done

  local create_cached=
  if echo $d/|grep -q $OTHERDIRS; then create_cached=1
  elif ! echo $d|grep -q /; then
    if ! echo $d|grep -q pages; then
      create_cached=1
    fi
  fi

  test -n "$create_cached" && mkdir -p $d/.cached

}

function scrubproglangsubdirs() {
  local d=$1

  local lang
  for lang in $ALL_PROGLANGS; do
    test -d "$d"/$lang && rm -fr "$d"/$lang
  done

  local subdir
  for subdir in "$d"/*; do
    test -d "$subdir" && scrubproglangsubdirs "$subdir"
  done
}

function shadowcopydir() {
  local srcdir=$1
  local tgtdir=$2
  mkdir -p "$tgtdir"

  local f
  for f in "$srcdir"/*; do
    local g=$(basename "$f")
    if test -f "$f"; then
      $CP -p "$f" "$tgtdir"
    elif test -d "$f"; then
      shadowcopydir "$f" "$tgtdir"/"$g"
    fi
  done
}

function dir_timestamp() {
  local d=$1
  # find the timestamp of the newest file in $d
  echo $(find $d -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f1 -d" " | sed -e 's/\..*//')
}

function save_previously_built_solution_pages() {
  # echo doing save_previously_built_solution_pages
  test -d solution-pages || return
  test -d .previously-built-solution-pages && rm -fr .previously-built-solution-pages
  mv solution-pages .previously-built-solution-pages
}

function make_image_list() {
  test -d images || return
  local image_list_file='images/.cached/.image-list.txt.kp'
  test -f $image_list_file && rm $image_list_file
  for f in images/*.json; do
    if test -f $f; then
      echo ${f#*/} >> $image_list_file
    fi
  done
}

function make_solution_pages() {
  # echo doing make_solution_pages
  test -d solution-pages-2 && rm -fr solution-pages-2
  test -d .previously-built-solution-pages && mv .previously-built-solution-pages solution-pages-2
  mkdir -p solution-pages-2
  if test -d pages; then
    # copy everything from pages to solution-pages-2 except *html. May need to make this more robust
    (find pages -maxdepth 0 -empty|grep -q .) || $CP -pr pages/*[^l] solution-pages-2 2>/dev/null
  fi
  $CP -p $TOPDIR/lib/.hta* solution-pages-2
  if test -d solution-pages; then
    shadowcopydir solution-pages solution-pages-2
    rm -fr solution-pages
  fi
  mv solution-pages-2 solution-pages
  test -d pages/.cached || mkdir -p pages/.cached
  test -d solution-pages/.cached || mkdir -p solution-pages/.cached
}

function check_slide_id() {
  local slideidfile=$1
  local ascfile=.cached/.index.asc
  local depgraphfile=$TOPDIR/distribution/$NATLANG/lib/dependency-graph.js
  test ! -f $ascfile && return
  test ! -f $slideidfile && return
  test $ascfile -nt $slideidfile && return
  rm -f $ascfile
  test -f $depgraphfile && rm -f $depgraphfile
}

function set_up_lesson_dir() {
  # echo set_up_lesson_dir "$@" in $(pwd)
  local pl=$1
  local firstproglang=$2
  mkdir -p .cached
  rm -f .cached/.page.starterfiles
  touch .cached/.proglang-$pl
  echo $pl > .cached/.record-proglang
  echo $superdir > .cached/.record-superdir
  # if test "$superdir" != Projects; then
  #   ${TOPDIR}/${MAKE_DIR}make-slides.lua
  # fi
  touch .cached/.redo
  test "$firstproglang" = $pl && touch .cached/.primarylesson

  for subdir in *; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done
  #
  make_solution_pages

  make_image_list

  # echo calling collect-work-pages.lua in $(pwd)
  $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
}
