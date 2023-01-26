# created 2023-01-19
# last modified 2023-01-26

test -f $RELEVANT_LESSONS_INPUT || exit

for lsn in $(cat $RELEVANT_LESSONS_INPUT); do
  L=distribution/$NATLANG/lessons/$lsn
  copacetic=1
  for f in $L/.cached/.*primtxt; do
    test -f $f || copacetic=
  done
  if test $copacetic; then
    cat $L/.cached/.*primtxt | sort -u > $L/.cached/.index-primitives.txt.kp
  fi
done
