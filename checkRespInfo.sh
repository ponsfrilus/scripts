#!/bin/bash
# Check resp info on cadi

## declare 	an array variable
#declare -a allUnits=("IGM" "ECPS" "ERCOFTAC" "GR-SCI-IGM" "IGM-GE" "LA-CO" "LA1" "LA2" "LA3" "LAMD" "LAMMM" "LCSM" "LENI" "LFMI" "LGPP" "LICP" "LMAF" "LMH" "LOMI" "LRESE" "LTCM" "MICROBS" "RRL" "SCI-STI-DK" "SCI-STI-FM" "SCI-STI-GFT" "SCI-STI-JVH" "SCI-STI-PO" "UNFOLD" "IGM-GE")
allUnits=$(ldapsearch -h ldap.epfl.ch -b 'ou=sti,o=epfl,c=ch' -LLL -x '(&(objectclass=organizationalunit))' ou | grep dn -A1 | grep "^ou" | cut -d " " -f 2 | sort)
for i in ${allUnits//\\n/ }
do
   myTest=$(curl -s https://cadiwww.epfl.ch/listes?unite=$i | grep -i respinfo.)
   if [[ $myTest = *[!\ ]* ]]; then
       echo "$i have a respinfo"
   else
       echo "$i dosen't have a respinfo - https://cadiwww.epfl.ch/listes?unite=$i"
   fi
done
