# usage: ./GetLDAPDataFromName.sh nicolas
ldapsearch -h ldap.epfl.ch -b 'c=ch' -x -LLL "(|(sn=$1*)(givenName=$1*))" displayname mail uniqueIdentifier roomNumber
