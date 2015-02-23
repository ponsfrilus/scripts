#!/bin/bash -
# title           :my_screen.sh
# description     :This script will set some display configuration
# author          :nbo
# email           :nicolas.borboen@epfl.ch
# date            :2015-02-23
# version         :0.3
# usage           :./my_screen.sh -h
# note            :Install xrandr to use this script
# ==============================================================================

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
verbose=0

echo "                      _______                         _______       "
echo ".--------.--.--.     |     __|.----.----.-----.-----.|    |  |      "
echo "|        |  |  |     |__     ||  __|   _|  -__|  -__||       |      "
echo "|__|__|__|___  |_____|_______||____|__| |_____|_____||__|____|_____ "
echo "         |_____|_nbo_|                                      |_2015_|"
echo ""

# Show help function
showHelp() {
    echo "This is a simple script to set display configuration faster than with the GUI menu."
    echo "  OPTIONS:"
    echo "    - h/? : show this help"
    echo "    - v   : verbose output/debug (set -x)"
    echo "    - d   : default (laptop only)"
    echo "    - m   : mirror displays"
    echo "    - b   : benq upper laptop"
    echo "    - l   : luminosity"
}

# testing input params
if [[ $# -eq 0 ]] ; then
    showHelp
    exit 0
fi

# testing xrandr
xrandr -v >/dev/null 2>&1 || { echo >&2 "Please install xrandr.  Aborting."; exit 1; }

# Set the panel on the correct display, then refresh xfce4 panels
setPanels() {
    # display = LVDS1 or DP1
    display=$1;

    if [[ $display == '' ]];then
      display='LVDS1'
    elif [[ $display == 'LVDS1' ]];then
      display='LVDS1'
    elif [[ $display == 'DP1' ]];then
      display='DP1'
    else
      exit 0
    fi;

    xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $display
    xfconf-query -c xfce4-panel -p /panels/panel-1/output-name -s $display
    xfce4-panel -r

    echo "... panels on $display have been refreshed."
}

# default set up, laptop only
default(){
    xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --off --output VGA1 --off
    setPanels 'LVDS1'
}

# mirror setup, screens mirrored
mirror() {
    xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --mode 2560x1440 --pos 0x0 --rotate normal --output VGA1 --off
    setPanels 'DP1'
}

# benq screen upper the laptop
benq() {
  xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 480x1440 --rotate normal --output VIRTUAL1 --off --output DP1 --mode 2560x1440 --pos 0x0 --rotate normal --output VGA1 --off
  setPanels 'LVDS1'
}

# set luminosity max
luminosity() {
    sudo -s
    echo 4000 > /sys/class/backlight/intel_backlight/brightness
}

# menu cases
while getopts "h?vdbml" opt; do
    case "$opt" in
    h|\?)
        showHelp
        exit 0
        ;;
    v)  verbose=1
        ;;
    d)
        echo "mode: default"
        default
        ;;
    m)
        echo "mode: mirror"
        mirror
        ;;
    b)
        echo "mode: benq"
        benq
        ;;
    l)
        echo "mode: luminosity"
        luminosity
        ;;
    esac
done

# debug mode
if [[ $verbose -eq 1 ]];then
  set -x
fi;

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# End of file
