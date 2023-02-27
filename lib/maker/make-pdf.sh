#!/bin/bash

# created 2023-01-20
# last modified 2023-02-25


# cd $TOPDIR/distribution/$NATLANG
cd $TOPDIR

echo "] }" >> $PUPPETEER_INPUT

if grep -q input $PUPPETEER_INPUT; then
  if test -n "$DEBUGNOBOOK"; then
    echo node lib/html2pdf.js $PUPPETEER_INPUT
  else
    node lib/html2pdf.js $PUPPETEER_INPUT
  fi
fi
