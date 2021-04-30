#!/bin/bash
# Source https://serverfault.com/a/295202/373021

estadistica () {
    local site=$1
    echo $site
    echo ${site} | sed -n 's/./-/gp'
    curl -w '
    Lookup time:\t%{time_namelookup} s
    Connect time:\t%{time_connect} s
    Pretransfer time:\t%{time_pretransfer} s
    Starttransfer time:\t%{time_starttransfer} s
    Size download:\t%{size_download} bytes
    Speed download:\t%{speed_download} bytes/s

    Total time:\t%{time_total} s
    ' -o /dev/null -s $site
    echo
    }

for i in ${@}; do
    estadistica $i
done
