#!/bin/bash

# echo doing make-contracts-pdf.sh

pdffile=$1

targetpathway=$(echo $pdffile|$SED -e 's/\/resources\/pages\/Contracts.pdf//' -e 's/.*\/courses\///')

# do only for pyret and wescheme?

inputfile="distribution/$NATLANG/Contracts.shtml?pathway=$targetpathway"
outputfile="distribution/$NATLANG/courses/$targetpathway/resources/pages/Contracts.pdf"
echo ", { \"input\": \"$inputfile\", \"output\": \"$outputfile\" }" >> $PUPPETEER_INPUT

inputfilesoln="distribution/$NATLANG/Contracts.shtml?pathway=$targetpathway&solns=true"
outputfilesoln="distribution/$NATLANG/courses/$targetpathway/resources/solution-pages/Contracts.pdf"
echo ", { \"input\": \"$inputfilesoln\", \"output\": \"$outputfilesoln\" }" >> $PUPPETEER_INPUT
