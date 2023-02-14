#!/bin/bash

# created 2023-02-13
# last modified 2023-02-13

# echo doing do-pathway-independent-pdf $1

adocfile=$1

whtmlfile=${adocfile%.adoc}.html

echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
