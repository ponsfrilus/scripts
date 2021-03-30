# ldapsearch

Currated list of `ldapsearch` commands.

## Search person info

`ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=104359`

## Search persons of a group by gid

`ldapsearch -v -x -LLL -h ldap.epfl.ch -b 'o=epfl,c=ch' gidNumber=10322`

## Search persons of a group by name

`ldapsearch -v -x -LLL -h ldap.epfl.ch -b 'c=ch' "(&(objectClass=posixAccount)(memberof=DemoValais))"`

```
ldapsearch -h ldap.epfl.ch -b 'o=epfl,c=ch' -LLL -x '(&(objectclass=organizationalunit))'

...
dn: ou=iif-ge,ou=iif,ou=ic,o=epfl,c=ch
ou: IIF-GE
ou: IIF - Gestion
description: IIF - Gestion
ou;lang-en: IIF - Administration
description;lang-en: IIF - Administration
postalAddress:: RVBGTCBJQyBJSUYtR0UgJCBJTlIgMzEwIChCw6J0aW1lbnQgSU5SKSAkIFN0YX
 Rpb24gMTQgJCBDSC0xMDE1IExhdXNhbm5l
labeledURI: http://iif.epfl.ch IIF-GE Home Page
facsimileTelephoneNumber: +41 21 6936625
uniqueIdentifier: 10404
accountingNumber: 1111
unitManager: 105326
memberURL: ldap:///ou=iif-ge,ou=iif,ou=ic,o=epfl,c=ch??sub?(objectClass=person
 )
...
```
 

## Search person info
`ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=104359`

## List all units of STI

`ldapsearch -h ldap.epfl.ch -b 'ou=sti,o=epfl,c=ch' -LLL -x '(&(objectclass=organizationalunit))' ou | grep dn -A1 | grep "^ou" | cut -d " " -f 2 | sort`

## Count the number of unit in a Institut

`ldapsearch -h ldap.epfl.ch -b 'ou=igm,ou=sti,o=epfl,c=ch' -LLL -x '(&(objectclass=organizationalunit))' ou | grep "dn: " -A1 | grep "ou: " | cut -c 4- | sort | wc -l`

## Get unit detail with unitID:

`ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x '(&(objectclass=organizationalunit)(uniqueIdentifier=10307))' dn`

## Get only unit name:

`ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=$i dn | cut -d '=' -f 2 | cut -d ',' -f 1`

## Get unitID from name:

`ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x '(&(objectclass=organizationalunit)(ou=IGM-GE))'`
