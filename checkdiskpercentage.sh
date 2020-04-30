#!/bin/bash
#
# This script check the disk usage and send mail to alert if the 
# "DISK_PERCENT_LIMIT threshold is reached.
#
# Use something similare to 
# */5   *   *   *   * root /path/to/this/scripts/checkdiskpercentage.sh >/dev/null 2>&1
# in your crontab

# set -x +e 

: ${DISK_TO_CHECK:=/dev/mapper/XXX-docker}
: ${DISK_PERCENT_LIMIT:=90}

DISK_TOTAL=$(df -h -text4 | grep $DISK_TO_CHECK | tr -s ' '| cut -d' ' -f2)
DISK_USED=$(df -h -text4 | grep $DISK_TO_CHECK | tr -s ' '| cut -d' ' -f3)
DISK_AVAIL=$(df -h -text4 | grep $DISK_TO_CHECK | tr -s ' '| cut -d' ' -f4)
DISK_PERCENT_USAGE=$(df -text4 | grep $DISK_TO_CHECK | tr -s ' '| cut -d' ' -f5 | cut -d '%' -f 1)

MAIL_SUBJECT="XXX disk usage warning"
MAIL_FROM="noreply+XXX@epfl.ch"
MAIL_TO="nicolas.borboen@epfl.ch"
MAIL_BODY=$(cat <<EOF
Total: ${DISK_TOTAL}
 - Used: ${DISK_USED}
 - Avail: ${DISK_AVAIL}
 - Percent: ${DISK_PERCENT_USAGE}%

KTHBAI
EOF
)

if [ "$DISK_PERCENT_USAGE" -gt "$DISK_PERCENT_LIMIT" ]
  then 
    echo "Greater than $DISK_PERCENT_LIMIT%";
    #echo -e "Subject:${MAIL_SUBJECT}\n${MAIL_BODY}" | sendmail -f "${MAIL_FROM}" -t "${MAIL_TO}"
    /usr/sbin/sendmail "${MAIL_TO}" <<EOF
subject:${MAIL_SUBJECT}
from:${MAIL_FROM}
Content-Type: text/plain
X-Priority: 1 (Highest)
X-MSMail-Priority: High

${MAIL_BODY}
EOF
  # else 
    # do nothing... echo "Less than $DISK_PERCENT_LIMIT%";
fi
