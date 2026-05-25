#! /usr/bin/env bash

lib_dir=$TOPDIR/distribution/$NATLANG/lib
self_guided_dir=$lib_dir/self-guided

if test ! -d $self_guided_dir/node_modules; then
  ln -sf $TOPDIR/node_modules $self_guided_dir/node_modules
fi

# Compute once: split entries in $self_guided_dir into dirs (symlinked)
# vs files (copied), so the per-lesson loop doesn't re-stat them each time.
sg_dirs=()
sg_files=()
for sgf in "$self_guided_dir"/*; do
  test -e "$sgf" || continue
  if test -d "$sgf"; then
    sg_dirs+=("$sgf")
  else
    sg_files+=("$sgf")
  fi
done

export SG_DIRS="${sg_dirs[*]}"
export SG_FILES="${sg_files[*]}"

create_local_self_guided() {
  local g=$1
  test -f "$g/selfGuidedBits.jsx" || return
  mkdir -p "$g/self-guided"
  cd "$g/self-guided" || return
  # shellcheck disable=SC2086
  for d in $SG_DIRS; do ln -sf "$d"; done
  # shellcheck disable=SC2086
  for f in $SG_FILES; do cp -p "$f" .; done
  mv ../selfGuidedBits.jsx .
  test -d ../images && ln -sf ../images
  test -d ../videos && ln -sf ../videos
}
export -f create_local_self_guided

if test -s $RELEVANT_LESSONS_LIST_FILE; then
  # if make called with COURSE=, only relevant lessons
  lesson_list=$(awk -v d="$TOPDIR/distribution/$NATLANG/lessons/" '{print d $0}' $RELEVANT_LESSONS_LIST_FILE)
else
  lesson_list=$(ls -d $TOPDIR/distribution/$NATLANG/lessons/*/)
fi

nproc=$(getconf _NPROCESSORS_ONLN)
echo "$lesson_list" | xargs -P "$nproc" -I {} bash -c 'create_local_self_guided "$@"' _ {}

# keep make happy with explicit exit 0
exit 0
