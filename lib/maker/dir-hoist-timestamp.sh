#!/bin/bash

# last modified 2023-03-04

function hoist() {
  local d=$1

  local dd
  for dd in "$d"/*; do
    if test -d "$dd"; then
      hoist "$dd"
      if test "$dd" -nt "$d"; then
        touch -r "$dd" "$d"
      fi
    fi
  done
}

hoist "$1" 
hoist "$2"
