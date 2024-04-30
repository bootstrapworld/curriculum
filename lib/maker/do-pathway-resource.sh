#!/bin/bash

# echo doing do-pathway-resource.sh $1

adocfile=$1

containingdirectory=$(dirname $adocfile)

test -d $containingdirectory/.cached || mkdir -p $containingdirectory/.cached

distrootdir=$(realpath --relative-to=$containingdirectory $TOPDIR/distribution/$NATLANG)/

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

otherdirarg="#f"

if echo $adocfile|grep -q $OTHERDIRS; then
  otherdirarg="#t"
fi

solutionsmodearg="#f"

if echo $adocfile|grep -q '/solution-pages/'; then
  solutionsmodearg="#t"
fi

resourcesarg="#f"

if echo $adocfile|grep -q '/resources/'; then
  resourcesarg="#t"
fi

targetpathway=$(echo $containingdirectory|$SED -e 's#.*/courses/\([^/]*\).*#\1#')

proglangarg=

for proglang in $ALL_PROGLANGS; do
  if test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-$proglang; then
    proglangarg=$proglang
  fi
done

# echo proglangarg is $proglangarg

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:other-dir $otherdirarg #:resources $resourcesarg #:target-pathway \"$targetpathway\" #:solutions-mode? $solutionsmodearg #:proglang \"$proglangarg\")" >>  $ADOCABLES_INPUT

if test $otherdirarg != "#t" ; then
  echo $ascfile >> $ADOC_INPUT

  if test $resourcesarg = "#t" -a $adocbasename = "index.adoc" -a $distrootdir = "../../../"; then
    echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_RESOURCES_INPUT
  else
    echo "  " \"$htmlfile\", >> $ADOC_POSTPROC_WORKBOOKPAGE_INPUT
  fi

  # echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
fi
