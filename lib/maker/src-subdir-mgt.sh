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
    # self-guided/node_modules is a symlink into a shared npm tree (~550
    # packages). Nothing in here is a proglang subdirectory, but recursing
    # in costs ~18s per lesson: the primary lesson dir escapes it only
    # because massage-distribution-lesson.sh's `rm -fr $d` happens to
    # delete the symlink first -- its alternate-proglang siblings are never
    # wiped, so they keep last build's symlink and pay the full walk.
    case "$subdir" in */node_modules) continue ;; esac
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
    case "$subdir" in */node_modules) continue ;; esac
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
  find "$d" -type f -printf '%T@\n' | sort -n | tail -1 | sed 's/\..*//'
}

function save_previously_built_solution_pages() {
  # echo doing save_previously_built_solution_pages
  test -d solution-pages || return
  test -d .previously-built-solution-pages && rm -fr .previously-built-solution-pages
  mv solution-pages .previously-built-solution-pages
}

function is_proglang_dir() {
  local d=$1
  local lang
  for lang in $ALL_PROGLANGS; do
    test "$d" = "$lang" && return 0
  done
  return 1
}

function flatten_image_subfolders() {
  test -d images || return
  # Check whether any non-.cached, non-proglang subdirs exist
  local has_subdirs=no
  for subdir in images/*/; do
    test -d "$subdir" || continue
    local dirname
    dirname=$(basename "$subdir")
    test "$dirname" = ".cached" && continue
    is_proglang_dir "$dirname" && continue
    has_subdirs=yes
    break
  done
  test "$has_subdirs" = no && return

  # Copy image files from subdirs to flat images/, warning on duplicates, both
  # across subdirs and between a subdir and images/ itself. A non-first
  # proglang variant (lesson-codap) is a copy of the already-flattened first
  # one, so its images/ already holds the earlier pass's copies, recorded in
  # flattened_list_file -- those aren't duplicates.
  local seen_list_file
  seen_list_file=$(mktemp)
  local flattened_list_file=images/.cached/.flattened-images.txt
  for subdir in images/*/; do
    test -d "$subdir" || continue
    local dirname
    dirname=$(basename "$subdir")
    test "$dirname" = ".cached" && continue
    is_proglang_dir "$dirname" && continue
    for img in "$subdir"*; do
      test -f "$img" || continue
      local imgbase
      imgbase=$(basename "$img")
      case "$imgbase" in *.json) continue;; esac  # handled separately below
      if grep -qxF "$imgbase" "$seen_list_file" 2>/dev/null; then
        echo "WARNING: $(basename "$PWD"): images/$imgbase appears in more than one subfolder; skipping duplicate" >&2
      elif test -f "images/$imgbase" && ! grep -qxF "$imgbase" "$flattened_list_file" 2>/dev/null; then
        echo "WARNING: $(basename "$PWD"): images/$imgbase also appears as images/$dirname/$imgbase; keeping images/$imgbase" >&2
      else
        echo "$imgbase" >> "$seen_list_file"
        cp "$img" "images/$imgbase"
      fi
    done
  done
  mkdir -p images/.cached
  mv "$seen_list_file" "$flattened_list_file"

  # Merge lesson-images.json files from all subdirs into images/lesson-images.json
  local proglangs_list="${ALL_PROGLANGS:-wescheme pyret codap spreadsheets none}"
  python3 - "$proglangs_list" <<'PYEOF'
import json, os, sys

images_dir = 'images'
skip = set(sys.argv[1].split()) | {'.cached'}
subdirs = sorted(d for d in os.listdir(images_dir)
                 if os.path.isdir(os.path.join(images_dir, d)) and d not in skip)
if not subdirs:
    sys.exit(0)

merged = {}
top_json = os.path.join(images_dir, 'lesson-images.json')
if os.path.exists(top_json):
    with open(top_json) as f:
        merged = json.load(f)

for subdir in subdirs:
    json_path = os.path.join(images_dir, subdir, 'lesson-images.json')
    if not os.path.exists(json_path):
        continue
    with open(json_path) as f:
        sub = json.load(f)
    for k, v in sub.items():
        if k not in merged:
            merged[k] = v
        elif merged[k] != v:
            # An identical entry is just this same subfolder re-merged --
            # e.g. a non-first proglang variant (lesson-codap) is a copy of
            # the already-flattened first one, so its top-level JSON already
            # holds these entries. Only a genuine conflict is worth a warning.
            print(f'WARNING: {os.path.basename(os.getcwd())}: duplicate image name {k!r} in images/lesson-images.json and'
                  f' images/{subdir}/lesson-images.json; keeping first occurrence', file=sys.stderr)

if merged:
    with open(top_json, 'w') as f:
        json.dump(merged, f, indent=2)
PYEOF
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

  flatten_image_subfolders
  make_image_list

  # echo calling collect-work-pages.lua in $(pwd)
  $TOPDIR/${MAKE_DIR}collect-workbook-pages.lua
}
