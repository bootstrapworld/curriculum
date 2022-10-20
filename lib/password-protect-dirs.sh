#!/bin/bash

DIR="$1"

for d in "$@"; do

  test -d "$d" || continue

  cd "$d"

  for f in *.html; do
    test -f "$f" || continue
    mv $f $SHAW-$f
    cp $PROGDIR/password-protect.html $f
    $SED -i \
      -e '/url=.*-index\.html/s/index\.html/'$f'/' \
      $f
  done

  for f in *.pdf; do
    test -f "$f" || continue
    mv $f $SHAW-$f
    # NOTE: X.pdf links should be given as X.pdf.html in webpages
    cp $PROGDIR/password-protect.html $f.html
    $SED -i \
      -e '/url=.*-index\.html/s/index\.html/'$f'/' \
      $f.html
  done

  cd $DISTDIR

done
