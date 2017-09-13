#!/bin/sh

USAGE="--> Usage: sh $0 ghuser1 ghuser2 ghuser3 ..."

if [ $# -ne 1 ]; then
    echo ""
    echo ${USAGE}
    echo
    exit
fi

AUTHORIZED_KEYS=$HOME/.ssh/authorized_keys
for USERNAME in "$@" ; do
    wget https://github.com/$USERNAME.keys -O - >> $AUTHORIZED_KEYS
done
