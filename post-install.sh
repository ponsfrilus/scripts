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
##	sudo ./post-install.sh


## http://tldp.org/LDP/abs/html/

if [ ! -w /etc/passwd ]; then
	echo "Super-user privileges are required.  Please run this with 'sudo ./post-install.sh'." >&2
	exit 1
fi




# Menu 1 : Dev Tools
menu1() { sudo apt-get install -y gedit vim git markdown; }
# Menu 2 : Geek Stuff
menu2() {
        echo "installing ZSH";
        sudo apt-get install zsh
        echo "change the default shell (answer /bin/zsh)";
        chsh
        echo "Read https://github.com/robbyrussell/oh-my-zsh#readme";
        echo "installing oh my zsh";
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
 }




showmenu = 0;
show_title() {
	clear;
	echo "  ++ponsfrilus++";
	echo "   ___          _      _____           _        _ _ ";
	echo "  / _ \___  ___| |_    \_   \_ __  ___| |_ __ _| | |";
	echo " / /_)/ _ \/ __| __|    / /\/ '_ \/ __| __/ _\` | | |";
	echo "/ ___/ (_) \__ \ |_  /\/ /_ | | | \__ \ || (_| | | |";
	echo "\/    \___/|___/\__| \____/ |_| |_|___/\__\__,_|_|_|";
	echo "        make the installation of *buntu stuff easier";
	echo "";
}

show_menu() {

	##read opt
	options=("Dev-Tools" "Geek Stuff" "Internet" "Multimedia" "Drawing" "Confort" "Multi-Screen" "Optimization")
	echo "Please select your objectives : "
	PS3="Pick an option : "
	select opt in "${options[@]}" "Quit"; do 
		case "$REPLY" in
			1 ) 	echo "$opt: will install gedit, vim, git, markdown, sublime"
				while true
					do
						read -r -p 'Dev-Tools option will install gedit, vim, git, markdown. Would you to continue [y/n] ? ' choice
						case "$choice" in
							n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
							y|Y) menu1
								break;;
						esac
					done
			    	;;

			2 ) echo "You picked $opt which is option $REPLY"
				menu2
			    ;;

			3 ) echo "You picked $opt which is option $REPLY";;

			$(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
			q|Q|Quit|quit|Exit|exit ) echo "Goodbye!"; break;;

			*) echo "Invalid option. Pick another one.";continue;;
		esac
	done
}

clear
show_title
show_menu

# Menu 1 : Dev Tools
menu1() { sudo apt-get install -y gedit vim git markdown; }
# Menu 2 : Geek Stuff
menu2() { 
	echo "installing ZSH";
	sudo apt-get install zsh
	echo "change the default shell (answer /bin/zsh)";
	chsh
	echo "Read https://github.com/robbyrussell/oh-my-zsh#readme";
	echo "installing oh my zsh";
	wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
 }

exit 0
#options=("Dev-Tools" "Geek Stuff" "Internet" "Multimedia" "Drawing" "Confort" "Multi-Screen" "Optimization")

#echo "Please select your objectives : "
#PS3="Pick an option : "
#select opt in "${options[@]}" "Quit"; do 
#
#    case "$REPLY" in

##    1 ) echo "You picked $opt which is option $REPLY";;
#    1 )	while true
#            do
#                read -r -p 'Dev-Tools option will install gedit, vim, git, markdown. Would you to continue [y/n] ? ' choice
#	        case "$choice" in
#	            n|N) break;;
#	            y|Y) sudo apt-get install -y gedit vim git markdown;;
#	        esac
#	done
#        ;;
#    2 ) echo "You picked $opt which is option $REPLY";;
#    3 ) echo "You picked $opt which is option $REPLY";;
#
#    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
#    *) echo "Invalid option. Pick another one.";continue;;
#
#    esac
#
#done








## Update depots
#sudo apt-get update

## http://www.webupd8.org/2012/11/how-to-use-multiple-monitors-in-xubuntu.html
## Make the Multiscreen available + Thunar Tabs
#sudo add-apt-repository ppa:xubuntu-dev/xfce-4.12
#sudo apt-get update
#sudo apt-get upgrade
#echo "Now run the following command to configure your displays:"
#echo "xfce4-display-settings -m"
#echo "And run the fillowing command to restart Thunar and have tabs support:"
#echo "thunar -q"

## OPTIMIZATION
## Cleaning UP
#sudo apt-get autoremove
## preload
## sudi apt-get autoclean


## DEV TOOLS
#sudo apt-get install vim git markdown
## export EDITOR="vim"

## GEEK Tools
#sudo apt-get install guake 
## oh my zhs, zhs

## INTERNET TOOLS
## chrome, opera

## MULTIMEDIA TOOLS
## VLC sudo apt-get install dvdrip
## sudo /usr/share/doc/libdvdread4/install-css.sh


## DRAWING TOOLS
#pinta gthumb


## CONFORT
## workrave

#echo "Installing f.lux"
#sudo add-apt-repository ppa:kilian/f.lux
#sudo apt-get update
#sudo apt-get install fluxgui


