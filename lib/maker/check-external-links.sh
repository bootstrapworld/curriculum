#! /usr/bin/env bash

BROKEN_EXTERNAL_LINKS=

for g in "$@"; do
  containingFile=${g%.external-links.txt.kp}
  containingFile=$(echo $containingFile|$SED -e 's/\.cached\/\.//').adoc

  for f in $(cat $g); do

    invalid=
    # possible alternative? wget -q --spider $f
    curl -Is $f > .temp.txt

    if test ! -s .temp.txt; then
      invalid=1
    elif ! cat .temp.txt|head -n 1|grep -q 302; then
      :
    elif cat .temp.txt|head -n 1|grep -q 200; then
      if cat .temp.txt|grep -q '^Connection: close'; then
        invalid=1
      fi
    fi

    rm .temp.txt

    if test $invalid; then
      BROKEN_EXTERNAL_LINKS=1
      echo
      echo WARNING: Invalid external link $f in $containingFile
    fi
  done
done

test -n "$BROKEN_EXTERNAL_LINKS" && touch distribution/$NATLANG/.cached/.check-external-links
