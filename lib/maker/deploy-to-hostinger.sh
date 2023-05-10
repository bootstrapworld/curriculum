#!/bin/bash

# last modified 2023-03-25

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

DEPLOYABLES_DIR=deployables-$USER

test -d $DEPLOYABLES_DIR && rm -fr $DEPLOYABLES_DIR

mkdir $DEPLOYABLES_DIR

ALL_THE_LANGS="en-us es-mx"

for lang in $ALL_THE_LANGS; do
  mkdir -p $DEPLOYABLES_DIR/$lang/courses
  mkdir -p $DEPLOYABLES_DIR/$lang/lessons
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
    cp -pr $lang/courses/$dir $DEPLOYABLES_DIR/$lang/courses/$dir
    correctgdriveurls $DEPLOYABLES_DIR/$lang/courses/$dir
  done
}

for lang in $ALL_THE_LANGS; do
  if test -z "$SKIPLIB"; then
    if test -d $lang/extlib; then
      cp -pr $lang/extlib $DEPLOYABLES_DIR/$lang
    else
      echo Skipping copying extlib...
    fi
  fi
  for f in $lang/*; do
    if test -f $f; then
      cp -p $f $DEPLOYABLES_DIR/$lang
    fi
  done
  if test -d $lang/lib; then
    cp -pr $lang/lib $DEPLOYABLES_DIR/$lang
  fi
  if test -d $lang/lessons; then
    cp -pr $lang/lessons $DEPLOYABLES_DIR/$lang
    correctgdriveurls $DEPLOYABLES_DIR/$lang/lessons
  fi
  if test -d $lang/courses; then
    cp -pr $lang/courses $DEPLOYABLES_DIR/$lang
    correctgdriveurls $DEPLOYABLES_DIR/$lang/courses
  fi
done

find $DEPLOYABLES_DIR -name .cached -type d -exec rm -fr {} \; > /dev/null 2>&1

for f in adoc asc aux md id rkt rkt.kp titletxt txt txt.kp; do
  find $DEPLOYABLES_DIR -name \*.$f -delete
done

find $DEPLOYABLES_DIR -name lesson-images.json -delete

cat > $DEPLOYABLES_DIR/deploy-to-public_html.sh <<EOF
DEPLOY_DIR=\$HOME/public_html/materials/$SEMESTER_YEAR
rm -fr \$DEPLOY_DIR
mv \$HOME/tmp/$DEPLOYABLES_DIR \$DEPLOY_DIR
rm \$DEPLOY_DIR/deploy-to-public_html.sh
EOF

CONVENIENT_PASSWORD=

(which sshpass|grep -q .) && CONVENIENT_PASSWORD=yes

if test -n "$CONVENIENT_PASSWORD"; then
  read -p "Password: " -s RSYNC_PASSWORD
  export SSHPASS="$RSYNC_PASSWORD"
fi

echo Copying $DEPLOYABLES_DIR to Hostinger...

if test -n "$CONVENIENT_PASSWORD"; then
  rsync -e "sshpass -e ssh -p $HOSTINGER_PORT" -rlptvz $DEPLOYABLES_DIR $HOSTINGER_USER@$HOSTINGER_IPADDR:tmp/.
else
  rsync -e "ssh -p $HOSTINGER_PORT" -rlptvz $DEPLOYABLES_DIR $HOSTINGER_USER@$HOSTINGER_IPADDR:tmp/.
fi

exitstatus=$?

test $exitstatus -ne 0 && echo rsync failed! 😢  && exit 0

echo Copying files to public_html/materials/$SEMESTER$YEAR...

if test -n "$CONVENIENT_PASSWORD"; then
  sshpass -e ssh -p $HOSTINGER_PORT $HOSTINGER_USER@$HOSTINGER_IPADDR "bash \$HOME/tmp/$DEPLOYABLES_DIR/deploy-to-public_html.sh"
else
  ssh -p $HOSTINGER_PORT $HOSTINGER_USER@$HOSTINGER_IPADDR "bash \$HOME/tmp/$DEPLOYABLES_DIR/deploy-to-public_html.sh"
fi

exitstatus=$?

test -n "$CONVENIENT_PASSWORD" && unset RSYNC_PASSWORD SSHPASS

test $exitstatus -ne 0 && echo ssh failed! 😢  && exit 0

echo Deployment done! 🙂 💐 🎉 🎊
