#!/bin/bash

USERS="nborboen"

for i in $USERS; do
    echo " -> $i :";
    ldapsearch -h ldap.epfl.ch -b 'o=epfl,c=ch' -LLL -x uid=$i | grep mail 
    echo " ";
done;
