#!/bin/bash
# https://stackoverflow.com/questions/35529922/filter-ldapsearch-with-awk-bash

READFILE=${1:-scipers.txt}
LDAPARG="mail|uniqueIdentifier|telephoneNumber|roomNumber|gecos"
while IFS='' read -r line || [[ -n "$line" ]]; do
  #ENTRY=$(ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=${line})
  ENTRY=$(ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x "(&(uniqueIdentifier=${line})(EPFLAccredOrder=1))")
  #echo -e "$ENTRY\n"
  printf %s "$ENTRY" |
  while IFS=': ' read -r key value; do
    case ${key} in
      mail|uniqueIdentifier|telephoneNumber|roomNumber|gecos|userClass)
        echo -e "$value;\c"
        #read -r "${key}" <<<"${value## }" ;;
        ;;
      *)
        continue
        ;;
    esac
    #[ "${key}" = userClass ] && printf "%s;%s\n" "${mail}" "${telephoneNumber}"
  done
  echo "\n"
done < "$READFILE"
# while IFS='' read -r line || [[ -n "$line" ]]; do
#   ldapsearch \
#       -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=${line} mail \
#   | \
#   sort -u \
#   | \
#   awk -F ': ' \
#       ' \
#       $1 ~ "mail" { \
#           printf ("%s\n", $2); \
#       }'
# done < "$1"
