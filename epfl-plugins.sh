#!/bin/bash

repos=(ws tequila accred newsletter persons)
CWD="$(pwd)"
echo "Current EPFL plugins directory is: $CWD"
read -r -p "Are you sure? [Y/n]" response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then

  # Removing existing repository if they exists
  if [ -d $CWD/epfl-ws ] || [ -d $CWD/epfl-tequila ] || [ -d $CWD/epfl-accred ] || [ -d $CWD/epfl-newsletter ]; then
    read -r -p "Some EPFL plugins exists, do you want to remove them? [Y/n] (/!\ you might loose uncommmited/unpushed changes)" response_pg
    response_pg=${response_pg,,} # tolower
    if [[ $response_pg =~ ^(yes|y| ) ]] || [[ -z $response_pg ]]; then
      for r in "${repos[@]}"
      do
        echo "...removing $CWD/epfl-$r"
        sudo rm -rf $CWD/epfl-$r
        echo "done"
      done
      echo "OK"
    fi
  fi

  # Run git clone for EPFL plugin repositories
  read -r -p "Do you want to try to create EPFL Plugins directories? [Y/n]" response_cr
  response_cr=${response_cr,,} # tolower
  if [[ $response_cr =~ ^(yes|y| ) ]] || [[ -z $response_cr ]]; then
    for r in "${repos[@]}"
    do
      echo "...cloning epfl-$r"
      git clone git@github.com:epfl-sti/wordpress.plugin.$r.git epfl-$r
      echo "done"
    done
    echo "OK"
  fi

  # Run git pull in the EPFL plugin repositories
  read -r -p "Do you want to try to updates EPFL Plugins? [Y/n]" response_up
  response_up=${response_up,,} # tolower
  if [[ $response_up =~ ^(yes|y| ) ]] || [[ -z $response_up ]]; then
    for r in "${repos[@]}"
    do
      echo "...entering epfl-$r"
      cd epfl-$r
      git pull
      cd ..
      echo "done"
    done
    echo "OK"
  fi

  # Run chown www-data -R for the EPFL plugin repositories
  read -r -p "Do you want to chown www-data -R ? [Y/n]" response_ch
  response_ch=${response_ch,,} # tolower
  if [[ $response_ch =~ ^(yes|y| ) ]] || [[ -z $response_ch ]]; then
    for r in "${repos[@]}"
    do
      echo "...chowning epfl-$r"
      sudo chown www-data:www-data -R epfl-$r
      echo "done"
    done
    echo "OK"
  fi

fi
