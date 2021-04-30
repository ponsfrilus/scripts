#!/usr/bin/env bash
set -e

# just postgres psql -U postgres -d postgres
# postgres=# \c goepfl
# \copy (SELECT email FROM users) to '/var/lib/postgresql/data/users20210429.txt';

# psql -U postgres -d goepfl -c "\copy (SELECT email FROM users) to '/var/lib/postgresql/data/dump.tsv5'";

# docker exec -it go_postgres psql -U postgres -d goepfl -t -c "select email from users;"
# docker exec -it go_postgres psql -U postgres -d goepfl -t --pset=pager=off  -c 'select email from users;'
rm -f ./out.txt || true

#input="./emails.txt"
# Note:
#   -t → no header
#   --pset=pager=off do not pipe results in "more"
EMAILS=$(docker exec -it go_postgres psql -U postgres -d goepfl -t --pset=pager=off  -c 'select email from users;')
AFTER=`echo $EMAILS | sed 's/\\r//g'`
AFTER2=`echo $AFTER | sed 's/ /\\n/g'`
echo "$AFTER2" > _emails.txt

while IFS= read -r mail
do
  echo "processing $mail..."
  #ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x "(&(mail=nicolas.borboen@epfl.ch)(employeeType=Personnel))"
  #ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x "(&(mail=exercicescoursccsap@epfl.ch)(employeeType=Personnel))"
  #ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x '(&(mail=exercicescoursccsap@epfl.ch)(!(employeeType=Ignore)))'
  ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x "(&(mail=${mail})(!(employeeType=Ignore)))" mail | grep mail: | cut -d' ' -f2 >> out.txt
  #ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x mail=$mail mail | grep mail: | cut -d' ' -f2 >> out.txt
#done < "$input"
done < "./_emails.txt"

echo "--------------------------------------------------------------------------------"
cat out.txt | sort -u > validatedEmail.txt
cat validatedEmail.txt
