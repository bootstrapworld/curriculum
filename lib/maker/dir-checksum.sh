# last modified 2023-03-03
#!/bin/bash

MDV=md5sum

(which md5|grep -q .) && MDV=md5

function dir_hasnt_changed() {
  local dir=$1
  local file=$2

  local newchecksum=$(find $dir -type f -exec $MDV {} \; | cut -d ' ' -f 1 | $MDV | cut -d ' ' -f 1)

  if test -f $file; then
    local oldchecksum=$(cat $file)
    test "$newchecksum" = "$oldchecksum" && return 0
  fi

  echo $newchecksum > $file
  return 1
}

