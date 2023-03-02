#!/bin/bash

# created 2023-01-20
# last modified 2023-03-01

cd $TOPDIR
lib/make-bilingual-glossary.rkt

GLOSSFILE=$TOPDIR/distribution/$NATLANG/lib/bilingual-glossary.adoc

mv bilingual-glossary.adoc $GLOSSFILE

asciidoctor -a linkcss -a stylesheet=asciidoctor.css $GLOSSFILE

rm $GLOSSFILE

if test -n "$BOOK"; then
  echo ", { \"input\": \"distribution/$NATLANG/lib/bilingual-glossary.html\" }" >> $PUPPETEER_INPUT
fi
