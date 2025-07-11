#! /usr/bin/env bash

# last modified 2025-07-11

if grep -q input $PUPPETEER_INPUT; then
  if test -n "$DEBUGNOBOOK"; then
    echo node lib/html2pdf.js $PUPPETEER_INPUT
  else
    node lib/html2pdf.js $PUPPETEER_INPUT
  fi
fi
