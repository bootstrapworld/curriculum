# created 2023-01-20
# last modified 2023-01-20

# echo doing builddependencyjson "$@"
cd $TOPDIR/distribution/$NATLANG/lessons
export DISTROOTDIR=../
GRAPHFILE=$TOPDIR/distribution/$NATLANG/dependency-graph.js
echo "var graph = {" > $GRAPHFILE
first=1
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
  if ! grep -q "^ *\"$Lbasename\"" $GRAPHFILE; then
    if test $first; then
      first=
    else
      echo "," >> $GRAPHFILE
    fi
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
    echo "  \"$Lbasename\" : {" >> $GRAPHFILE
    echo "    title: \"$titletxt\"," >> $GRAPHFILE
    echo "    description: \"$desctxt\"," >> $GRAPHFILE
    echo "    pages: [$pagestxt]," >> $GRAPHFILE
    echo "    exercisePages: [$exerpagestxt]," >> $GRAPHFILE
    echo "    primitives: [$primstxt]," >> $GRAPHFILE
    if test -f $L/.cached/.lesson-keywords.txt.kp; then
      cat $L/.cached/.lesson-keywords.txt.kp >> $GRAPHFILE
    fi
    echo -n "    prerequisites: [" >> $GRAPHFILE
    pfirst=1
    if test -f $L/.cached/.lesson-prereq.txt.kp; then
      for p in $(cat $L/.cached/.lesson-prereq.txt.kp); do
        if test $pfirst; then
          pfirst=
        else
          echo -n ", " >> $GRAPHFILE
        fi
        echo -n "\"$p\"" >> $GRAPHFILE
      done
    fi
    echo "]," >> $GRAPHFILE
    if test -f $L/.cached/.lesson-standards-w-prose.txt.kp; then
      cat $L/.cached/.lesson-standards-w-prose.txt.kp >> $GRAPHFILE
    fi
    echo "  }" >> $GRAPHFILE
  fi
done
echo "}" >> $GRAPHFILE
# convert to UTF-16 to handle curlyquotes
iconv -f UTF-8 -t UTF-16 $GRAPHFILE > tmp.txt
mv -f tmp.txt $GRAPHFILE
#rm tmp.txt
