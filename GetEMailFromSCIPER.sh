#!/bin/bash
# J. Menu - 21/12/2012


# "-------------------------------------------------------------------------"
# "--> Check usage and arguments"
# "-------------------------------------------------------------------------"

USAGE="--> Usage: $0 SCIPER"

if [ $# -ne 1 ]; then
    echo ""
    echo ${USAGE}
    echo
    exit
fi


SCIPER=$1

ldapsearch \
    -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=${SCIPER} mail \
| \
sort -u \
| \
awk -F ': ' \
    ' \
    $1 ~ "mail" { \
        printf ("%s\n", $2); \
    }'
