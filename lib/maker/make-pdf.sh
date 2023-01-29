# created 2023-01-20
# last modified 2023-01-28

cd $TOPDIR/distribution/$NATLANG

echo "] }" >> $PUPPETEER_INPUT

if grep -q input $PUPPETEER_INPUT; then
  node lib/html2pdf.js $PUPPETEER_INPUT
fi
