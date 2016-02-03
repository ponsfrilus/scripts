#!/bin/bash

# Usage
# MySQLUSER="test" MySQPASSWORD="helloMySQL" MySQOUTPUT="/home/user/Documents/MySQLdumps" ./test.sh
set -e -x

: ${MySQLUSER:="root"}
: ${MySQPASSWORD:="nrj+2020"}
: ${MySQOUTPUT:="/home/nborboen/Documents/MySQLdumps"}

echo $MySQLUSER
echo $MySQPASSWORD
echo $MySQOUTPUT
