#!/bin/bash
if [ -z "$1" ]
then
  echo "arg is not defined"
  exit
fi


if cat /home/core/.ssh/known_hosts | grep -q $1
  then 
    echo "$1 FOUND"
    sed -i '/^'"$1"'*/d' /home/core/.ssh/known_hosts
    echo "$1 entry removed from .ssh/known_hosts"
  else 
    echo "$1 NOT FOUND"
fi
# Tests
# sed '/^'"$1"'*/d' /home/core/.ssh/known_hosts
# sed '/^$1*/d' .ssh/known_hosts
