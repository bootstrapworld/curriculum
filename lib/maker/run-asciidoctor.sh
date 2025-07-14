#! /usr/bin/env bash

# echo starting run-asciidoctor.sh

cssfile=$TOPDIR/distribution/$NATLANG/lib/curriculum.css

if git rev-parse --show-toplevel >/dev/null 2>/dev/null; then
  export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
else
  export SOURCE_DATE_EPOCH=$(date -d $(date +%Y-%m-%d) +%s)
fi

if test -z "$ASCIIDOCTOR_NODE"; then
  if test -z "$DEBUGADOC"; then
    asciidoctor -a linkcss -a stylesheet=$cssfile -a cachedir=.cached/ -B . $(cat $ADOC_INPUT) > $MAKE_ERR_LOG 2>&1
  else
    echo $'\e[1;31m'🐌 Will be slow! Running asciidoctor once per file because DEBUGADOC=$DEBUGADOC $'\e[0m'
    for f in $(cat $ADOC_INPUT); do
      rm -f $MAKE_ERR_LOG; touch $MAKE_ERR_LOG
      # echo asciidoctor $f
      echo -n .
      asciidoctor -a linkcss -a stylesheet=$cssfile -a cachedir=.cached/ -B . $f > $MAKE_ERR_LOG 2>&1
      if test -s "$MAKE_ERR_LOG"; then
        echo
        echo Error occurred while asciidoctoring $f
        cat $MAKE_ERR_LOG
      fi
    done
    echo
  fi
else
  NODE_ADOC_INPUT=$ADOC_INPUT-node.js
  echo "let adocFiles = [" > $NODE_ADOC_INPUT
  cat $ADOC_INPUT | $SED -e 's/.*/"\0",/' >> $NODE_ADOC_INPUT
  echo "];" >> $NODE_ADOC_INPUT
  echo "module.exports = adocFiles;" >> $NODE_ADOC_INPUT
  #
  node lib/callAdoc.js $NODE_ADOC_INPUT 
fi

if test -f $MAKE_ERR_LOG; then
  if test -s $MAKE_ERR_LOG; then
    cat $MAKE_ERR_LOG
  else
    rm -f $MAKE_ERR_LOG
  fi
fi
