#!/bin/bash

# created 2023-01-14
# last modified 2023-02-13

# echo doing do-pathway-resource.sh $1

adocfile=$1

fcontainingdirectory=$(dirname $adocfile)

test -d $fcontainingdirectory/.cached || mkdir -p $fcontainingdirectory/.cached

distrootdir=$(realpath --relative-to=$fcontainingdirectory $TOPDIR/distribution/$NATLANG)/

containingdirectory=$(realpath --relative-to=$TOPDIR/distribution/$NATLANG $fcontainingdirectory)

adocbasename=$(basename $adocfile)

ascfile=$containingdirectory/.cached/.${adocbasename%.adoc}.asc

htmlfile=${ascfile%.asc}.html

otherdirarg="#f"

if $(echo $adocfile|grep -q '/\(fragments\|xtra\|xtras\)/'); then
  otherdirarg="#t"
fi

solutionsmodearg="#f"

if $(echo $adocfile|grep -q '/solution-pages/'); then
  solutionsmodearg="#t"
fi

resourcesarg="#f"

if $(echo $adocfile|grep -q '/resources/'); then
  resourcesarg="#t"
fi

targetpathway=$(echo $containingdirectory|$SED -e 's#courses/\([^/]*\).*#\1#')

if test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-codap; then proglangarg=codap
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-none; then proglangarg=none
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-spreadsheets; then proglangarg=spreadsheets
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-wescheme; then proglangarg=wescheme
elif test -f distribution/$NATLANG/courses/$targetpathway/.cached/.proglang-pyret; then proglangarg=pyret
fi

# echo proglangarg is $proglangarg

echo "(\"$adocbasename\" #:containing-directory \"$containingdirectory\" #:dist-root-dir \"$distrootdir\" #:other-dir $otherdirarg #:resources $resourcesarg #:target-pathway \"$targetpathway\" #:solutions-mode? $solutionsmodearg #:proglang \"$proglangarg\")" >>  $ADOCABLES_INPUT


if test $otherdirarg != "#t" ; then
  echo $ascfile >> $ADOC_INPUT

  if test $resourcesarg = "#t" -a $adocbasename = "index.adoc" -a $distrootdir = "../../../"; then
    echo $htmlfile >> $ADOC_POSTPROC_RESOURCES_INPUT
  else
    echo $htmlfile >> $ADOC_POSTPROC_WORKBOOKPAGE_INPUT
  fi

  # echo ", { \"input\": \"$whtmlfile\" }" >> $PUPPETEER_INPUT
fi
