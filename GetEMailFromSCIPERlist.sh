#!/bin/bash

set -e +x
SCIPERARY="118771 248167 212553 212584 236293 216086 212454 205157 202384 228396 248838 224254 225794 236538 224358 105551 155576 195691 175718 100957 181119 185859"


for sciper in `echo $SCIPERARY`  
do
  ldapsearch -h ldap.epfl.ch -b 'c=ch' -LLL -x uniqueIdentifier=$sciper | grep mail | cut -d ":" -f2 | head -n 1 | tr -d ' '
done


