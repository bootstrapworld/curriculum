#!/bin/bash

# created 2023-02-13
# last modified 2023-02-15

# echo doing do-workbook-page-pdf $1

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

lessondirectory=$(echo $containingdirectory|$SED -e 's#\(lessons/[^/]*\).*#\1#')

test -f distribution/$NATLANG/$lessondirectory/.proglang-ignore && exit

whtmlfile=${adocfile%.adoc}.html

aspect=portrait

if head -5 $adocfile|grep -q '^ *\[\.landscape] *$'; then
  aspect=landscape
fi

otherdirarg="#f"

if $(echo $adocfile|grep -q '/\(fragments\|xtra\|xtras\)/'); then
  otherdirarg="#t"
fi

if test $otherdirarg = "#f" ; then
  echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"$aspect\" }" >> $PUPPETEER_INPUT
fi
