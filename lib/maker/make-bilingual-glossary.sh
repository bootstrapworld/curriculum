# created 2023-01-20
# last modified 2023-01-27

cd $TOPDIR
$PROGDIR/make-bilingual-glossary.rkt

GLOSSFILE=$TOPDIR/distribution/$NATLANG/lib/bilingual-glossary.adoc

mv bilingual-glossary.adoc $GLOSSFILE

asciidoctor -a linkcss -a stylesheet=asciidoctor.css $GLOSSFILE

rm $GLOSSFILE

echo ", { \"input\": \"lib/bilingual-glossary.html\" }" >> $PUPPETEER_INPUT
