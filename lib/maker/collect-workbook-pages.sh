#!/bin/bash

# created 2023-01-20
# last modified 2023-02-19

function collect_workbook_pages() {
  # echo doing collect_workbook_pages in $(pwd)

  test -d pages || return

  test -f pages/workbook-pages.txt ||
    touch pages/workbook-pages.txt

  #ensure workbook-pages.txt ends in newline, or while isn't happy
  $SED -i -e '$a\' pages/workbook-pages.txt

  rm -f pages/.cached/.workbook-{pages,pages-ls,notes-pages-ls}.txt.kp

  test -f pages/.cached/.workbook-pages-ls.txt.kp ||
    touch pages/.cached/.workbook-pages-ls.txt.kp

  while read -r f; do
    # echo finding aspect of "$f"
    g=$f
    if echo "$f"|grep -q '^ *;'; then
      :
    elif echo "$f"|grep -q '^ *//'; then
      :
    elif echo "$f"|grep -q '^ *$'; then
      :
    elif echo "$f"|grep -q landscape; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
    elif echo "$f"|grep -q portrait; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
    elif test "${f%.adoc}" = "$f"; then
      # f is not an adoc file
      echo $f >> pages/.cached/.workbook-pages.txt.kp
    elif test ! -f "$f"; then
      # f doesn't (yet?) exist
      echo $f >> pages/.cached/.workbook-pages.txt.kp
    elif head -n 5 "$f"|grep -q '^ *\[\.landscape\] *$'; then
      echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
    elif head -n 60 "$f"|grep -q 'body.*landscape'; then
      echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
    else
      echo $f >> pages/.cached/.workbook-pages.txt.kp
    fi
    echo $g >> pages/.cached/.workbook-pages-ls.txt.kp
  done < pages/workbook-pages.txt

}
