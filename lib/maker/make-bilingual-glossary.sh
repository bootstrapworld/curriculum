#!/bin/bash

# last modified 2023-03-04

# echo doing make-bilingual-glossary.sh

export GLOSSFILE=distribution/$NATLANG/lib/bilingual-glossary

lib/make-bilingual-glossary.rkt

asciidoctor -a linkcss -a stylesheet=asciidoctor.css $GLOSSFILE.adoc

rm $GLOSSFILE.adoc

if test -n "$BOOK"; then
  echo ", { \"input\": \"$GLOSSFILE.html\" }" >> $PUPPETEER_INPUT
fi
