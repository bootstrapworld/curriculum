# created 2023-01-20
# last modified 2023-02-06

cd $TOPDIR/distribution/$NATLANG

find . -type f -name \.\*external-links.txt.kp | xargs $PROGDIR/checkexternallinks
find . -type f -name \.\*internal-links.txt.kp | xargs $PROGDIR/checkinternallinks
