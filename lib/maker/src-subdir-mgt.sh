#!/bin/bash

# last modified 2023-04-11

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

function make_solution_pages() {
  test -d solution-pages-2 && rm -fr solution-pages-2
  $CP -pr pages solution-pages-2
  $CP -p $TOPDIR/lib/.hta* solution-pages-2
  if test -d solution-pages; then
    shadowcopydir solution-pages solution-pages-2
    rm -fr solution-pages
  fi
  mv solution-pages-2 solution-pages
  test -d pages/.cached || mkdir -p pages/.cached
  test -d solution-pages/.cached || mkdir -p solution-pages/.cached
}
