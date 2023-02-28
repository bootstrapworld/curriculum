#!/bin/bash

# last modified 2023-02-28

cd $TOPDIR

echo "] }" >> $PUPPETEER_INPUT

if grep -q input $PUPPETEER_INPUT; then
  if test -n "$DEBUGNOBOOK"; then
    echo node lib/html2pdf.js $PUPPETEER_INPUT
  else
    node lib/html2pdf.js $PUPPETEER_INPUT
  fi
fi
