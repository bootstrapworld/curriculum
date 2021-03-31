#!/bin/bash

# html2pdf.sh f.html
#   creates corresponding PDF file in f.pdf
#
# html2pdf.sh -l f.html
#   same, but in landscape mode
#
# This script is only offered for debugging convenience. The
# build script does many such conversions in parallel and thus
# saves time that can't be done here.

LANDSCAPE=
SED=sed

while test $# -ne 0; do
  arg=$1; shift
  if test "$arg" = -l; then
    LANDSCAPE=1
  else
    fhtml=$arg
  fi
done

if which gsed | grep -q .; then
  SED=gsed
fi

fpdf=${fhtml%.html}.pdf

ghtml=${fhtml%.html}-tmp.html

cp $fhtml $ghtml

function removecodetags() {
  local f=$1
  $SED -i \
    -e 's/<code>\(<tt\)/\1/g' \
    -e 's/\(<\/tt>\)<\/code>/\1/g' \
    $f
}

removecodetags $ghtml

JAVASCRIPTDELAY="--run-script 'MathJax.Hub.Queue(function(){window.status=\"ready_to_print\"})' --window-status ready_to_print"

ASPECT="--margin-bottom 18mm --margin-right 12.7mm --margin-top 12.7mm --margin-left 12.7mm"

if test $LANDSCAPE; then
  ASPECT="-O Landscape --margin-top 0mm --margin-right 20mm --margin-bottom 0mm --margin-left 20mm"
fi

echo wkhtmltopdf --enable-local-file-access --print-media-type --dpi 300 $JAVASCRIPTDELAY $ASPECT -q $ghtml $fpdf
wkhtmltopdf --enable-local-file-access --print-media-type --dpi 300 $JAVASCRIPTDELAY $ASPECT -q $ghtml $fpdf
