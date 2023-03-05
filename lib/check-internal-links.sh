#!/bin/bash

# last modified 2023-03-01

BROKEN_INTERNAL_LINKS=

for g in "$@"; do

  containingFile=${g%.internal-links.txt.kp}
  containingFile=$(echo $containingFile|sed -e 's/\.cached\/\.//').adoc

  for f in $(cat $g); do

    if ! test -f "$f"; then
      BROKEN_INTERNAL_LINKS=1
      echo
      echo WARNING: Invalid internal link $f in $containingFile
    fi
  done
done

test -n "$BROKEN_INTERNAL_LINKS" && touch distribution/$NATLANG/.cached/.check-internal-links
