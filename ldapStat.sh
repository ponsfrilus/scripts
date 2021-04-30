#!/bin/bash

UNITS=$(ldapsearch -h ldap.epfl.ch -b 'ou=sti,o=epfl,c=ch' -LLL -x '(&(objectclass=organizationalunit))' ou \
    | grep dn -A1 \
    | grep "^ou" \
    | cut -d " " -f 2 \
    | sort
    )

lc () {
  echo $1 | tr '[:upper:]' '[:lower:]'
}
a
#echo $UNITS;
for i in $UNITS; do
  #echo $i;
  lc $i;
done
