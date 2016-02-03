#!/bin/bash
# Usage
# MySQLUSER="test" MySQPASSWORD="MyFantasticPassword" MySQOUTPUT="/home/user/Documents/MySQLdumps" ./rsync_bck.sh

set -x

: ${MySQLUSER:="root"}
: ${MySQPASSWORD:="MyFantasticPassword"}
: ${MySQOUTPUT:="/home/nborboen/Documents/MySQLdumps"}
 
rm "$MySQOUTPUT/*gz" > /dev/null 2>&1
 
databases=`mysql --user=$MySQLUSER --password=$MySQPASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
 
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --force --opt --user=$MySQLUSER --password=$MySQPASSWORD --databases $db > $MySQOUTPUT/`date +%Y%m%d`.$db.sql
        gzip $MySQOUTPUT/`date +%Y%m%d`.$db.sql
    fi
done
mkdir $MySQOUTPUT/`date +%Y%m%d`
mv $MySQOUTPUT/*.sql.gz $MySQOUTPUT/`date +%Y%m%d`
