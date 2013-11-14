#!/bin/bash

echo "ScreenShot in bash"
hash gnome-screenshot 2>/dev/null || { echo >&2 "Sorry, gnome-screenshot is required, install it first.  Aborting."; exit 1; }

# Time in seconds between 2 screenshot
t=1
# Number of times you want to do it
n=10
# Relative path to store screenshots
p="./" # relative path !

ans=$(( $t * $n ))
echo ". Running for $ans seconds"

echo " . Start `date`"
x=1
while [ $x -le $n ]
do
  echo " -- screenshot `date +%F\ %T`"
  # filename
  fn=$(printf %04d $x).png
  # filepath
  fp=$p$fn
  #echo $f
  gnome-screenshot -w -b --border-effect=shadow --file="$fp"
  x=$(( $x + 1 ))
  # sleep 10 s
  sleep $t
done
echo "End `date`"
