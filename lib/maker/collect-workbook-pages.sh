#!/bin/bash

# created 2023-01-20
# last modified 2023-02-09

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
    aspect=portrait
    g=$f
    if echo "$f"|grep -q '^ *;'; then
      :
    elif echo "$f"|grep -q '^ *//'; then
      :
    elif echo "$f"|grep -q landscape; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> pages/.cached/.workbook-pages-ls.txt.kp
      aspect=landscape
    elif echo "$f"|grep -q portrait; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> pages/.cached/.workbook-pages-ls.txt.kp
    elif test "${f%.adoc}" = "$f"; then
      echo $f >> pages/.cached/.workbook-pages.txt.kp
      echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
    else
      if test -f "$f" && head -n 5 "$f"|grep -q '^ *\[\.landscape\] *$'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      elif test -f "$g" && head -n 60 "$g"|grep -q 'body.*landscape'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      else
        echo $f >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> pages/.cached/.workbook-pages-ls.txt.kp
      fi
    fi
  done < pages/workbook-pages.txt

}
