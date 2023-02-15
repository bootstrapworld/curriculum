#!/bin/bash

# created 2023-02-13
# last modified 2023-02-15

# echo doing do-lesson-plan-pdf $1

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

test -f $fcontainingdirectory/.proglang-ignore && exit

whtmlfile=${adocfile%.adoc}.shtml

echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"portrait\" }" >> $PUPPETEER_INPUT
