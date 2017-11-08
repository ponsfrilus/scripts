#!/bin/bash
# IRB: User.all.collect(&:email)

USERS="email1@epfl.ch email2@epfl.ch email3@epfl.ch"

TMP=''
CNT=0
echo "" > fac.txt
for i in $USERS; do
    ((CNT++))
    TMP=$(ldapsearch -h ldap.epfl.ch -b 'o=epfl,c=ch' -LLL -x mail=$i dn | head -1)
    FAC=$(echo $TMP | cut -d',' -f4 | cut -d'=' -f2)
    if [ ! -z "$FAC" ]
    then
        echo $FAC >> fac.txt
    fi
done;

# Total User
TOTAL=$(cat fac.txt | wc -l)
echo "Total users = $TOTAL (without $(($CNT-$TOTAL)) empty users, i.e. left)"
echo " "
echo "Faculty apportionment:"
# remove blank line
cat fac.txt | tr -s '\n' '\n' | sort > fin.txt
mv fin.txt fac.txt
awk '
/:/||/^$/{next}{a[toupper($0)]++}
END{for(i in a) print "  - " i,a[i]}' fac.txt
