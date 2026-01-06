#! /usr/bin/env bash

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

CURR_GIT_BRANCH=$(git branch --show-current)

# DEPLOY_DIR_SUBSTR is a part of the eventual DEPLOY_DIR path on the server.
# It differs based on whether we're deploying from 'website' vs some other branch

if test "$CURR_GIT_BRANCH" = website; then
  # hostinger allows for multiple domains, so make sure we're
  # deploying to the right one!
  DOMAIN=beta.bootstrapworld.org
  DEPLOY_DIR_SUBSTR=domains/beta.bootstrapworld.org/public_html/materials/$SEMESTER_YEAR
else
  DEPLOY_DIR_SUBSTR=public_html/materials/$SEMESTER_YEAR
fi

test -d $DEPLOYABLES_DIR && rm -fr $DEPLOYABLES_DIR

mkdir $DEPLOYABLES_DIR

ALL_THE_LANGS="en-us es-mx"

for lang in $ALL_THE_LANGS; do
  mkdir -p $DEPLOYABLES_DIR/$lang
done

SEMESTER_YEAR=$SEMESTER$YEAR

SED=sed

(which gsed | grep -q .) && SED=gsed

for lang in $ALL_THE_LANGS; do
  for d in $lang/*; do
    if test -f $d; then
      cp -p $d $DEPLOYABLES_DIR/$lang
    elif test -d $d; then
      if test "$d" = $lang/extlib; then
        test -n "$SKIPLIB" && continue
      fi
      mkdir -p $DEPLOYABLES_DIR/$d
      cp -pr $d $DEPLOYABLES_DIR/$lang
    fi
  done
done

find $DEPLOYABLES_DIR -name .cached -type d -exec rm -fr {} \; > /dev/null 2>&1

for f in adoc asc aux md id rkt rkt.kp titletxt txt txt.kp; do
  find $DEPLOYABLES_DIR -name \*.$f -delete
done

for f in $(find $DEPLOYABLES_DIR -name images -type d); do
  find $f -name \*.json -delete
done

cat > $DEPLOYABLES_DIR/deploy-to-public_html.sh <<EOF
DEPLOY_DIR=\$HOME/$DEPLOY_DIR_SUBSTR
rm -fr \$DEPLOY_DIR
mv \$HOME/tmp/$DEPLOYABLES_DIR \$DEPLOY_DIR
rm \$DEPLOY_DIR/deploy-to-public_html.sh
#chmod 755 \$DEPLOY_DIR/\*/lessons/hoc-winter-parley/repartee
EOF

# exit

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

echo Copying files to $DEPLOY_DIR_SUBSTR...

if test -n "$CONVENIENT_PASSWORD"; then
  sshpass -e ssh -p $HOSTINGER_PORT $HOSTINGER_USER@$HOSTINGER_IPADDR "bash \$HOME/tmp/$DEPLOYABLES_DIR/deploy-to-public_html.sh"
else
  ssh -p $HOSTINGER_PORT $HOSTINGER_USER@$HOSTINGER_IPADDR "bash \$HOME/tmp/$DEPLOYABLES_DIR/deploy-to-public_html.sh"
fi

exitstatus=$?

test -n "$CONVENIENT_PASSWORD" && unset RSYNC_PASSWORD SSHPASS

test $exitstatus -ne 0 && echo ssh failed! 😢  && exit 0

echo Deployment done! 🙂 💐 🎉 🎊
