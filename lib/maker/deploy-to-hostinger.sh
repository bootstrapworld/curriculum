#!/bin/bash

# last modified 2023-03-24

test ! -d distribution && echo distribution/ not found\; make it first && exit 0

# env vars HOSTINGER_PORT, HOSTINGER_USER, HOSTINGER_IPADDR *must* be set!
# but don't set them here, for security reasons

exitp=

test -z "$HOSTINGER_PORT" && echo Please set HOSTINGER_PORT && exitp=yes
test -z "$HOSTINGER_USER" && echo Please set HOSTINGER_USER && exitp=yes
test -z "$HOSTINGER_IPADDR" && echo Please set HOSTINGER_IPADDR && exitp=yes

test -n "$exitp" && exit 0

# set env vars SEMESTER and YEAR to reflect where you want the
# curriculum pages to be deployed on the server.

test -z "$SEMESTER" && SEMESTER=fall
test -z "$YEAR" && YEAR=$(date +%Y)-BETA

############################################################################

cd distribution

test -d deployables && rm -fr deployables

mkdir deployables

ALL_THE_LANGS="en-us es-mx"

for lang in $ALL_THE_LANGS; do
  mkdir -p deployables/$lang/courses
  mkdir -p deployables/$lang/lessons
done

SEMESTER_YEAR=$SEMESTER$YEAR

SED=sed

(which gsed | grep -q .) && SED=gsed

function correctgdriveurl_1() {
  local f=$1
  $SED -i -e '/href=/s/\(spring\|fall\)[0-9][0-9][0-9][0-9]/'$SEMESTER_YEAR'/g' $f
}

function correctgdriveurls() {
  local d=$1
  for f in $(find $d -name \*gdrive-import.shtml); do
    correctgdriveurl_1 $f
  done
}

function copyCourse() {
  local dir=$1
  for lang in $ALL_THE_LANGS; do
    test -d $lang/courses/$dir || continue
    cp -pr $lang/courses/$dir deployables/$lang/courses/$dir
    correctgdriveurls deployables/$lang/courses/$dir
  done
}

for lang in $ALL_THE_LANGS; do
  if test -z "$SKIPLIB"; then
    if test -d $lang/extlib; then
      cp -pr $lang/extlib deployables/$lang
    else
      echo Skipping copying extlib...
    fi
  fi
  for f in $lang/*; do
    if test -f $f; then
      cp -p $f deployables/$lang
    fi
  done
  if test -d $lang/lib; then
    cp -pr $lang/lib deployables/$lang
  fi
  if test -d $lang/lessons; then
    cp -pr $lang/lessons deployables/$lang
    correctgdriveurls deployables/$lang/lessons
  fi
  if test -d $lang/courses; then
    cp -pr $lang/courses deployables/$lang
    correctgdriveurls deployables/$lang/courses
  fi
done

find deployables -name .cached -type d -exec rm -fr {} \; > /dev/null 2>&1

for f in adoc asc aux md id rkt rkt.kp titletxt txt txt.kp; do
  find deployables -name \*.$f -delete
done

find deployables -name lesson-images.json -delete

echo Copyng deployables to Hostinger...
rsync -e "ssh -p $HOSTINGER_PORT" -avz deployables $HOSTINGER_USER@$HOSTINGER_IPADDR:tmp/.

exitstatus=$?

test $exitstatus -ne 0 && echo rsync failed! 😢  && exit 0

cat > deploy-to-public_html.sh <<EOF
DEPLOY_DIR=\$HOME/public_html/materials/$SEMESTER_YEAR
mkdir -p \$DEPLOY_DIR
cd
cd tmp
cp -pr deployables/* \$DEPLOY_DIR
EOF

echo Unpacking files under public_html/materials/$SEMESTER$YEAR...
ssh -p $HOSTINGER_PORT $HOSTINGER_USER@$HOSTINGER_IPADDR 'bash ~/tmp/deploy-to-public_html.sh'

exitstatus=$?

test $exitstatus -ne 0 && echo ssh failed! 😢  && exit 0

echo Deployment done! 🙂 💐 🎉 🎊
