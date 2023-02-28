#!/bin/bash

# last modified 2023-02-28

# echo doing do-lesson-plan-pdf $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

test -f $containingdirectory/.proglang-ignore && exit

whtmlfile=${adocfile%.adoc}.shtml

echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"portrait\" }" >> $PUPPETEER_INPUT
