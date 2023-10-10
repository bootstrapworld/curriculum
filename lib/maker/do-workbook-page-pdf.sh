#!/bin/bash

# echo doing do-workbook-page-pdf $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

lessondirectory=$(echo $containingdirectory|$SED -e 's#.*/lessons/\([^/]*\).*#\1#')

test -f distribution/$NATLANG/lessons/$lessondirectory/.proglang-ignore && exit

whtmlfile=${adocfile%.adoc}.html

aspect=portrait

if head -5 $adocfile|grep -q '^ *\[\.landscape] *$'; then
  aspect=landscape
fi

otherdirarg="#f"

if $(echo $adocfile|grep -q $OTHERDIRS); then
  otherdirarg="#t"
fi

if test $otherdirarg = "#f" ; then
  echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"$aspect\" }" >> $PUPPETEER_INPUT
fi
