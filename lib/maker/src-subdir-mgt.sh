#!/bin/bash

function adjustproglangsubdirs() {
  local d=$1
  local pl=$2

  test -d "$d"/"$pl" && $CP -p "$d"/"$pl"/* "$d"

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

function save_old_solution_pages() {
  # echo doing save_old_solution_pages
  test -d solution-pages || return
  test -d solution-pages-3 && rm -fr solution-pages-3
  mv solution-pages solution-pages-3
}

function make_solution_pages() {
  # echo doing make_solution_pages
  test -d solution-pages-2 && rm -fr solution-pages-2
  test -d solution-pages-3 && mv solution-pages-3 solution-pages-2
  mkdir -p solution-pages-2
  if test -d pages; then
    # copy everything from pages to solution-pages-2 except *html. May need to make this more robust
    (find pages -maxdepth 0 -empty|grep -q .) || $CP -pr pages/*[^l] solution-pages-2
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

function set_up_lesson_dir() {
  local lessonNamePl=$1
  local pl=$2
  local firstproglang=$3
  cd "$lessonNamePl"
  mkdir -p .cached
  touch .cached/.proglang-$pl
  echo $pl > .cached/.record-proglang
  echo $superdir > .cached/.record-superdir
  ${TOPDIR}/${MAKE_DIR}make-slides.lua
  touch .cached/.redo
  test "$firstproglang" = $pl && touch .cached/.primarylesson
  test -d pages || mkdir pages

  for subdir in *; do
    test -d "$subdir" && adjustproglangsubdirs "$subdir" "$pl"
  done
  #
  make_solution_pages

  # echo calling collect-work-pages.lua in $(pwd)
  $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
  cd ..
}
