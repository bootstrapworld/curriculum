#!/bin/bash

# echo doing do-pathway-resource-pdf $1

adocfile=$1

adocbasename=$(basename $adocfile)

resourcesarg="#f"

if echo $adocfile|grep -q '/resources/'; then
  resourcesarg="#t"
fi

otherdirarg="#f"

if echo $adocfile|grep -q $OTHERDIRS; then
  otherdirarg="#t"
fi

whtmlfile=${adocfile%.adoc}.html

if test $otherdirarg = "#f" ; then

  if echo $adocfile|grep -q '/resources/index.adoc$'; then
    whtmlfile=${adocfile%.adoc}.shtml
  fi

  echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
fi
