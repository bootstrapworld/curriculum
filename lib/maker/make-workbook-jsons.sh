# created 2023-01-20
# last modified 2023-02-08

NOPARALLEL=1

function make_workbook_json_1() {

  # echo doing make_workbook_json_1 $1 in $(pwd)

  local tgt=$1

  local WORKBOOKINPUT=.cached/.filelist

  local wbpnf=
  local includesolutions=
  local includeoptexercises=

  if test "$tgt" = bm-contracts -o "$tgt" = bm-contracts-sols; then
    wbpnf=.cached/.back-matter-contracts-index.rkt
  #elif test "$tgt" = workbook -o "$tgt" = pd-workbook -o "$tgt" = workbook-sols; then
  elif test "$tgt" = workbook -o "$tgt" = workbook-sols; then
    wbpnf=.cached/.workbook-page-index.rkt
  elif test "$tgt" = opt-exercises -o "$tgt" = opt-exercises-sols; then
    wbpnf=.cached/.opt-exercises-index.rkt
  else
    wbpnf=.cached/.workbook-long-page-index.rkt
  fi

  if test "$tgt" = workbook-sols -o "$tgt" = bm-contracts-sols -o "$tgt" = workbook-long-sols -o "$tgt" = opt-exercises-sols; then
    includesolutions=1
  fi

  #if test "$tgt" = workbook-long -o "$tgt" = pd-workbook-long -o "$tgt" = workbook-long-sols -o "$tgt" = opt-exercises -o "$tgt" = opt-exercises-sols; then
  if test "$tgt" = workbook-long -o "$tgt" = workbook-long-sols -o "$tgt" = opt-exercises -o "$tgt" = opt-exercises-sols; then
    includeoptexercises=1
  fi

  #echo Initializing $WORKBOOKINPUT_$tgt

  echo "{ \"fileList\": [ \"ignoreElement\" " > $WORKBOOKINPUT-$tgt.json

  local currlesson=
  local pdfpagespec lessondir workbookpage aspect pageno freshlesson
  local docfile docfileext htmlfile localpdffile

  cat $wbpnf |
    while read -r pdfpagespec; do
      # echo processing $pdfpagespec
      if echo $pdfpagespec|grep -qv '\(lessons\|front-matter\|back-matter\)'; then
        continue
      fi
      lessondir=$(echo $pdfpagespec|$SED -e 's/^("\([^"]*\).*/\1/')
      workbookpage=$(echo $pdfpagespec|$SED -e 's/^("[^"]*" *"\([^"]*\).*/\1/')
      aspect=$(echo $pdfpagespec|$SED -e 's/^("[^"]*" *"[^"]*" *"\([^"]*\).*/\1/')
      pageno=$(echo $pdfpagespec|$SED -e 's/^("[^"]*" *"[^"]*" *"[^"]*" *"\?\([^")]*\).*/\1/')

      if test "$pageno" = no -o "$pageno" = No -o "$pageno" = NO; then
        pageno=false
      fi

      if test "$pageno" != false; then
        pageno=true
      fi

      freshlesson=
      if test "$lessondir" != "$currlesson"; then
        freshlesson=1
      fi

      if test "$freshlesson"; then
        currlesson=$lessondir
        docfile=$currlesson/index.shtml
        #if test -f "$docfile"; then
        #  if test "$tgt" = pd-workbook -o "$tgt" = pd-workbook-long; then
        #    echo $currlesson/index.pdf >> $WORKBOOKINPUT-$tgt
        #  fi
        #fi
      fi

      if test $includesolutions; then
        docfile=$lessondir/solution-pages/$workbookpage
      else
        docfile=$lessondir/pages/$workbookpage
      fi

      docfileext=${docfile##*.}

      if test "$docfileext" = adoc; then
        docfile=${docfile%.adoc}.html
        docfileext=html
      elif test "$docfileext" = pdf; then
        htmlfile=${docfile%.pdf}.html
        if test -f $htmlfile; then
          docfile=$htmlfile
          docfileext=html
        fi
      fi

      #echo docfile= $docfile
      #echo docfileext= $docfileext

      if test "$docfileext" = html; then
        if test -f "$docfile"; then
          localpdffile=${docfile%.html}.pdf

          echo ", { \"file\": \"$localpdffile\", \"paginate\": $pageno }" >> $WORKBOOKINPUT-$tgt.json

        else
          echo ", { \"file\": \"../../lib/$ABYSS.pdf\", \"paginate\": $pageno }" >> $WORKBOOKINPUT-$tgt.json
        fi

      elif test ! -f $docfile; then
        echo ", { \"file\": \"../../lib/$ABYSS.pdf\", \"paginate\": $pageno }" >> $WORKBOOKINPUT-$tgt.json

      else
        echo ", { \"file\": \"$docfile\", \"paginate\": $pageno }" >> $WORKBOOKINPUT-$tgt.json

      fi

    done

    echo "] }" >> $WORKBOOKINPUT-$tgt.json

    # echo Finished with $WORKBOOKINPUT-$tgt.json

}

function make_workbook_jsons() {
  # echo doing make_workbook_json in $(pwd)
  for wbf in workbook bm-contracts bm-contracts-sols workbook-sols workbook-long \ workbook-long-sols opt-exercises opt-exercises-sols ; do
    if test -z "$NOPARALLEL"; then
      make_workbook_json_1 $wbf &
    else
      make_workbook_json_1 $wbf
    fi
  done
  test -z "$NOPARALLEL" && wait
}
