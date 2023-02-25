#!/bin/bash

# created 2023-01-20
# last modified 2023-02-25

# echo doing builddependencyjson "$@"
cd $TOPDIR/distribution/$NATLANG/lessons
echo "var graph = {" > $GRAPH_FILE
for L in *; do
  # echo try proglangversion $L
  # if ! proglangversion $L; then
  #   # echo discarding $L
  #   continue
  # fi
  # echo L is $L
  Lbasename=$L

  if test $(echo $L|grep "\-wescheme"); then
    Lbasename=${L%-wescheme}
  fi

  # echo Lbasename is $Lbasename

  # the following sanity checks shdnt be needed
  #test -d "$L" || continue
  #if test "$L" = lib; then continue; fi
  if ! grep -q "^ *\"$Lbasename\"" $GRAPH_FILE; then
    titletxt=
    if test -f $L/.cached/.index.titletxt; then
      titletxt=$(cat $L/.cached/.index.titletxt|$SED -e 's/"/\\"/g')
    fi
    desctxt=
    if test -f $L/.cached/.index-desc.txt.kp; then
      desctxt=$(cat $L/.cached/.index-desc.txt.kp|$SED -e 's/"/\\"/g')
    fi
    pagestxt=
    if test -f $L/pages/.cached/.workbook-pages-ls.txt.kp; then
      pagestxt=$(cat $L/pages/.cached/.workbook-pages-ls.txt.kp|$SED -e ':a' -e 'N' -e '$!ba' -e 's/\n/\", \"/g'|$SED -e 's/.*/\"\0\"/')
    fi
    exerpagestxt=
    if test -f $L/pages/.cached/.exercise-pages-ls.txt.kp; then
      exerpagestxt=$(cat $L/pages/.cached/.exercise-pages-ls.txt.kp|$SED -e ':a' -e 'N' -e '$!ba' -e 's/\n/\", \"/g'|$SED -e 's/.*/\"\0\"/')
    fi
    primstxt=
    if test -f $L/.cached/.index-primitives.txt.kp; then
      primstxt=$(cat $L/.cached/.index-primitives.txt.kp|$SED -e ':a' -e 'N' -e '$!ba' -e 's/\n/\", \"/g'|$SED -e 's/.*/\"\0\"/')
    fi
    echo "  \"$Lbasename\" : {" >> $GRAPH_FILE
    echo "    title: \"$titletxt\"," >> $GRAPH_FILE
    echo "    description: \"$desctxt\"," >> $GRAPH_FILE
    echo "    pages: [$pagestxt]," >> $GRAPH_FILE
    echo "    exercisePages: [$exerpagestxt]," >> $GRAPH_FILE
    echo "    primitives: [$primstxt]," >> $GRAPH_FILE
    if test -f $L/.cached/.lesson-keywords.txt.kp; then
      cat $L/.cached/.lesson-keywords.txt.kp >> $GRAPH_FILE
    fi
    echo -n "    prerequisites: [" >> $GRAPH_FILE
    if test -f $L/.cached/.lesson-prereq.txt.kp; then
      for p in $(cat $L/.cached/.lesson-prereq.txt.kp); do
        echo -n "\"$p\", " >> $GRAPH_FILE
      done
    fi
    echo "]," >> $GRAPH_FILE
    if test -f $L/.cached/.lesson-standards-w-prose.txt.kp; then
      cat $L/.cached/.lesson-standards-w-prose.txt.kp >> $GRAPH_FILE
    fi
    echo "  }," >> $GRAPH_FILE
  fi
done
echo "}" >> $GRAPH_FILE
# convert to UTF-16 to handle curlyquotes
iconv -f UTF-8 -t UTF-16 $GRAPH_FILE > tmp.txt
mv -f tmp.txt $GRAPH_FILE
#rm tmp.txt
