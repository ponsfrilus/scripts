#!/bin/bash
# J. Menu - 16/01/2013


# "-------------------------------------------------------------------------"
# "--> Check usage and arguments"
# "-------------------------------------------------------------------------"

USAGE="--> Usage: $0 userName|SCIPER"

if [ $# -ne 1 ]; then
    echo ""
    echo ${USAGE}
    echo
    exit 1
fi

#echo "--> \$1 = $1"

case "$1" in
    [a-z][a-z]* )
	USER_NAME=$1
	SCIPER=$(GetSCIPERFromUsername.sh ${USER_NAME})
	;;

    [0-9][0-9]* )
	SCIPER=$1
	USER_NAME=$(GetUsernameFromSCIPER.sh ${SCIPER})
	;;
esac

EMAIL=$(GetEMailFromSCIPER.sh ${SCIPER})

echo
echo "--> USER_NAME              = ${USER_NAME}"
echo "--> SCIPER                 = ${SCIPER}"
echo "--> EMAIL                  = ${EMAIL}"
echo

ldapsearch \
    -v -x -LLL -h ldap.epfl.ch -b 'o=epfl,c=ch' \
    uniqueIdentifier=${SCIPER} dn \
    2>&1 \
    grep -v 'ldap_initialize' | \
    grep -v 'requesting' | \
    grep 'dn:'

echo
