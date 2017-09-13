#!/bin/sh

USAGE="--> Usage: sh $0 ghuser1 ghuser2 ghuser3 ..."

if [ $# -lt 1 ]; then
    echo ""
    echo ${USAGE}
    echo
    exit
fi

AUTHORIZED_KEYS_DIR=$HOME/.ssh
mkdir -p $AUTHORIZED_KEY_DIR
AUTHORIZED_KEYS_PATH=$AUTHORIZED_KEYS_DIR/authorized_keys
for USERNAME in "$@" ; do
    wget https://github.com/$USERNAME.keys -O - >> $AUTHORIZED_KEYS_PATH
done
