# created 2023-01-20
# last modified 2023-01-20

function collect_workbook_pages() {
  # echo doing collect_workbook_pages $1 in $(pwd)
  d=$1

  test -d $d/pages || return

  test -f $d/pages/.cached/.workbook-pages-ls.txt.kp ||
    touch $d/pages/.cached/.workbook-pages-ls.txt.kp

  while read -r f; do
    # echo finding aspect of "$f"
    aspect=portrait
    g=$f
    if echo "$f"|grep -q '^ *;'; then
      :
    elif echo "$f"|grep -q '^ *//'; then
      :
    elif echo "$f"|grep -q landscape; then
      echo $f >> $d/pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> $d/pages/.cached/.workbook-pages-ls.txt.kp
      aspect=landscape
    elif echo "$f"|grep -q portrait; then
      echo $f >> $d/pages/.cached/.workbook-pages.txt.kp
      g=$(echo $f|$SED -e 's/^ *\([^ ]\+\).*/\1/')
      echo $g >> $d/pages/.cached/.workbook-pages-ls.txt.kp
    elif test "${f%.adoc}" = "$f"; then
      echo $f >> $d/pages/.cached/.workbook-pages.txt.kp
      echo $f >> $d/pages/.cached/.workbook-pages-ls.txt.kp
    else
      if test -f "$f" && head -n 5 "$f"|grep -q '^ *\[\.landscape\] *$'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> $d/pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      elif test -f "$g" && head -n 60 "$g"|grep -q 'body.*landscape'; then
        echo $f landscape >> pages/.cached/.workbook-pages.txt.kp
        echo $f >> $d/pages/.cached/.workbook-pages-ls.txt.kp
        aspect=landscape
      else
        echo $f >> $d/pages/.cached/.workbook-pages.txt.kp
        echo $f >> $d/pages/.cached/.workbook-pages-ls.txt.kp
      fi
    fi
  done < $d/pages/workbook-pages.txt

}
