#!/bin/bash
##
## @title	Post Install *buntu
## @author	ponsfrilus
## @email	ponsfrilus@gmail.com
## @date	2013-05-29
## @version	0.0.1
##
## Usage:
##	chmod +x post-install.sh
##	sudo sh post-install.sh

set -e

if [ ! -w /etc/passwd ]; then
    echo "Super-user privileges are required.  Please run this with 'sudo'." >&2
    exit 1
fi

echo "Installing some stuff after a fresh install of *buntu:"

## Update depots
sudo apt-get update

## http://www.webupd8.org/2012/11/how-to-use-multiple-monitors-in-xubuntu.html
## Make the Multiscreen available + Thunar Tabs
sudo add-apt-repository ppa:xubuntu-dev/xfce-4.12
sudo apt-get update
sudo apt-get upgrade
echo "Now run the following command to configure your displays:"
echo "xfce4-display-settings -m"
echo "And run the fillowing command to restart Thunar and have tabs support:"
echo "thunar -q"

## OPTIMIZATION
## Cleaning UP
sudo apt-get autoremove
## preload
## sudi apt-get autoclean


## DEV TOOLS
sudo apt-get install vim git markdown


## GEEK Tools
sudo apt-get install guake 
## oh my zhs, zhs

## INTERNET TOOLS
## chrome, opera

## MULTIMEDIA TOOLS
## VLC
## sudo /usr/share/doc/libdvdread4/install-css.sh


## DRAWING TOOLS
#pinta gthumb


## CONFORT
## workrave

echo "Installing f.lux"
sudo add-apt-repository ppa:kilian/f.lux
sudo apt-get update
sudo apt-get install fluxgui


