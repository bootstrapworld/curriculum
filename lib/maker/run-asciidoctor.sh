# created 2023-01-19
# last modified 2023-01-21

cd $TOPDIR/distribution/$NATLANG

$PROGDIR/adocables-preproc.rkt $ADOCABLES_INPUT

rm -f .cached/.do-asciidoctor.js-split*

tmpf=.cached/.do-asciidoctor.js

if test ! -f "$tmpf"; then exit; fi

split -l 100 $tmpf $tmpf-split

# echo calling asciidoctor in dir $(pwd)

for f in $tmpf-split*; do
  asciidoctor -a linkcss -a stylesheet=lib/curriculum.css -a cachedir=.cached/ -B . $(cat $f)
done
