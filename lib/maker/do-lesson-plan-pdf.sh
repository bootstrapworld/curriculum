#!/bin/bash

# created 2023-02-13
# last modified 2023-02-13

# echo doing do-lesson-plan-pdf $1

adocfile=$1

whtmlfile=${adocfile%.adoc}.shtml

echo ", { \"input\": \"$whtmlfile\", \"aspect\": \"portrait\" }" >> $PUPPETEER_INPUT
