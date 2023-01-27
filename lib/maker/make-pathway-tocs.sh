# created 2023-01-20
# last modified 2023-01-27

cd $TOPDIR/distribution/$NATLANG/courses
export DISTROOTDIR=../
TOCSFILE=$TOPDIR/distribution/$NATLANG/pathway-tocs.js

echo "var pathwayTocs = {" > $TOCSFILE
first=1
for C in *; do
  if test $first; then
    first=
  else
    echo "," >> $TOCSFILE
  fi
  echo -n "   \"$C\": [" >> $TOCSFILE
  thisPathwayLessons=
  if test -f $C/.cached/.workbook-lessons.txt.kp; then
    thisPathwayLessons=$(cat $C/.cached/.workbook-lessons.txt.kp|$SED -e 's/.*\/lessons\///'|$SED -e ':a' -e 'N' -e '$!ba' -e 's/\n/\", \"/g'|$SED -e 's/.*/\"\0\"/')
  fi
  echo -n $thisPathwayLessons >> $TOCSFILE
  echo "]" >> $TOCSFILE
done
echo "}" >> $TOCSFILE
