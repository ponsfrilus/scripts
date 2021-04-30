#!/bin/bash

# Utilisation :
# ./getSciperFromEmail.sh emails.txt > out.txt
while IFS='' read -r line || [[ -n "$line" ]]; do
  ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x mail=$line uniqueIdentifier | grep uniqueIdentifier | cut -d ":" -f2 | head -n 1 | tr -d ' '
done < "$1"
