#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
verbose=0

echo " __   __  __   __  ______   ___   _______  _______  ___      _______  __   __  _______ "
echo "|  |_|  ||  | |  ||      | |   | |       ||       ||   |    |   _   ||  | |  ||       |"
echo "|       ||  |_|  ||  _    ||   | |  _____||    _  ||   |    |  |_|  ||  |_|  ||  _____|"
echo "|       ||       || | |   ||   | | |_____ |   |_| ||   |    |       ||       || |_____ "
echo "|       ||_     _|| |_|   ||   | |_____  ||    ___||   |___ |       ||_     _||_____  |"
echo "| ||_|| |  |   |  |       ||   |  _____| ||   |    |       ||   _   |  |   |   _____| |"
echo "|_|   |_|  |___|  |______| |___| |_______||___|    |___nbo_||__| |__|  |___|  |_2015__|"
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
}
if [[ $# -eq 0 ]] ; then
    showHelp
    exit 0
fi
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

default(){
    xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --off --output VGA1 --off
    setPanels 'LVDS1'
}

mirror() {
    xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output DP1 --mode 2560x1440 --pos 0x0 --rotate normal --output VGA1 --off
    setPanels 'DP1'
}

benq() {
  xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 480x1440 --rotate normal --output VIRTUAL1 --off --output DP1 --mode 2560x1440 --pos 0x0 --rotate normal --output VGA1 --off
  setPanels 'LVDS1'
}

while getopts "h?vdbm" opt; do
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
    esac
done

if [[ $verbose -eq 1 ]];then
  set -x
fi;

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

#echo "verbose=$verbose, output_file='$output_file', Leftovers: $@"

# End of file
