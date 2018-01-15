#!/bin/sh
# Usage: curl -s -L https://raw.githubusercontent.com/ponsfrilus/scripts/master/addKeysFromGithub.sh | bash -s ponsfrilus domq loichu

USAGE="--> Usage: sh $0 ghuser1 ghuser2 ghuser3 ..."

if [ $# -lt 1 ]; then
    echo ""
    echo ${USAGE}
    echo
    exit
fi

AUTHORIZED_KEYS_DIR=$HOME/.ssh
mkdir -p $AUTHORIZED_KEYS_DIR
AUTHORIZED_KEYS_PATH=$AUTHORIZED_KEYS_DIR/authorized_keys
for USERNAME in "$@" ; do
    wget https://github.com/$USERNAME.keys -O - >> $AUTHORIZED_KEYS_PATH
done
