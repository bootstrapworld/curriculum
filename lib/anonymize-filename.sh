#!/bin/bash

f="$1"

#echo anonymizing $f >> ~/j.txt

fd=$(dirname -- $f)

if test "$fd" = "."; then fd=""
else fd="$fd/"
fi

#echo fd is $fd>>~/j.txt

fb=$(basename -- $f)

fe=${fb##*.}

if test "$fe" = "$fb"; then fe=""
else fe=".$fe"
  fb=$(basename -- $fb $fe)
fi

#echo fb is $fb >> ~/j.txt
#echo fe is $fe >> ~/j.txt

# fbb=$(echo $fb|git hash-object --stdin|sed -e 's/^\(.\{16\}\).*/\1/')

fbb=$(echo -n $fb| shasum |sed -e 's/^\(.\{16\}\).*/\1/')

anonf="$fd$fbb$fe"

#echo destination $anonf >> ~/j.txt

echo "$anonf"
