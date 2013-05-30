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

# Menu 1 : Dev Tools
menu1() { 
	sudo apt-get install -y gedit vim git markdown;
	echo "installation of Sublime Text";
	sudo add-apt-repository ppa:webupd8team/sublime-text-2
	sudo apt-get update
	sudo apt-get install sublime-text
 }
# Menu 2 : Geek Stuff
menu2() {
        echo "installing ZSH";
        sudo apt-get install zsh
        echo "change the default shell (answer /bin/zsh)";
        chsh
        echo "Read https://github.com/robbyrussell/oh-my-zsh#readme";
        echo "installing oh my zsh";
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
	echo "In EPFL, you can change you default shell in "
	echo "https://dinfo.epfl.ch/cgi-bin/accountprefs"
	sudo apt-get install openssh-server
}

# Menu 3 : Internet
menu3(){
	sudo apt-get install chromium-browser	
}

# Menu 4: Multimedia
menu4(){
	echo "multimedia stuff";
	sudo apt-get install vlc ffmpeg mplayer dvdrip
## sudo /usr/share/doc/libdvdread4/install-css.sh
}

# Menu 5: Drawing
menu5(){
	echo "Drawing stuff";
	sudo apt-get install inkscape gimp gthumb pinta 
}

# Menu 6: Confort
menu6(){
	echo "Confort stuff";
	#sudo apt-get install inkscape gimp gthumbs pinta 
## CONFORT
## workrave

#echo "Installing f.lux"
#sudo add-apt-repository ppa:kilian/f.lux
#sudo apt-get update
#sudo apt-get install fluxgui
}

# Menu 7 : Multi screen
menu7(){
	## http://www.webupd8.org/2012/11/how-to-use-multiple-monitors-in-xubuntu.html
	## Make the Multiscreen available + Thunar Tabs
	sudo add-apt-repository ppa:xubuntu-dev/xfce-4.12
	sudo apt-get update
	sudo apt-get upgrade
	echo "Now run the following command to configure your displays:"
	echo "xfce4-display-settings -m"
	echo "And run the fillowing command to restart Thunar and have tabs support:"
	echo "thunar -q"
}

# Menu 8: Optimization
menu8(){
	echo "Drawing stuff";
	sudo apt-get install inkscape gimp gthumb pinta 
}
## OPTIMIZATION
## Cleaning UP
#sudo apt-get autoremove
## preload
## sudo apt-get autoclean


show_menu() {

	##read opt
	##	  $1		$2		$3		$4		$5		$6		$7		$8
	options=("Dev-Tools"	"Geek Stuff"	"Internet"	"Multimedia"	"Drawing"	"Confort"	"Multi-Screen"	"Optimization")
	echo "Please select your objectives : "
	PS3="Pick an option (press enter to see choices): "
	select opt in "${options[@]}" "All" "Quit (or q)"; do 
		case "$REPLY" in
			1 ) 	echo "$opt: will install gedit, vim, git, markdown, sublime"
				while true
					do
						read -r -p 'Dev-Tools option will install gedit, vim, git, markdown. Would you to continue [y/n] ? ' choice
						case "$choice" in
							n|N) clear; break;; ##TODO: find a way to show_menu() again without recusrivity
							y|Y) menu1
								break;;
						esac
					done
			    	;;

			2 )	echo "$opt: will install "
                                while true
                                        do
                                                read -r -p 'Geek Stuffs option will install zsh, oh my zsh, openssh-server. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu2
                                                                break;;
                                                esac
                                        done
                                ;;

			3 )	echo "$opt: will install chromium browser"
                                while true
                                        do
                                                read -r -p 'Internet option will install chromium. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu3
                                                                break;;
                                                esac
                                        done
                                ;;
			
			4 )	echo "$opt: will install vlc, mplayer, ffmpeg"
                                while true
                                        do
                                                read -r -p 'Multimedia option will install vlc, mplayer, ffmpeg. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu4
                                                                break;;
                                                esac
                                        done
                                ;;

			5 )	echo "$opt: will install inkscape gimp gthumbs pinta "
                                while true
                                        do
                                                read -r -p 'Drawing option will install inkscape gimp gthumbs pinta . Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu5
                                                                break;;
                                                esac
                                        done
                                ;;

			6 )	echo "$opt: will install ? "
                                while true
                                        do
                                                read -r -p $opt ' option will install workrave and flux. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu6
                                                                break;;
                                                esac
                                        done
                                ;;

			7 )	echo "$opt: will install  MultiScreen "
                                while true
                                        do
                                                read -r -p $opt ' option will install ppa:xubuntu-dev/xfce-4.12 and new xfce4-display-settings. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu7
                                                                break;;
                                                esac
                                        done
                                ;;

			8 )	echo "$opt: will autoremove and autoclean and install preload ? "
                                while true
                                        do
                                                read -r -p $opt ' option will install ?. Would you to continue [y/n] ? ' choice
                                                case "$choice" in
                                                        n|N) break;; ##TODO: find a way to show_menu() again without recusrivity
                                                        y|Y) menu8
                                                                break;;
                                                esac
                                        done
                                ;;
			
			$(( ${#options[@]}+1 )) ) echo "You are a crazy monkey !"
						menu1 
						menu2
						menu3
						menu4
						menu5
						menu6
						menu7
						menu8
					break;;

			$(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;

			q|Q|Quit|quit|Exit|exit ) echo "Goodbye!"; break;;

			*) echo "Invalid option. Pick another one.";continue;;
		esac
	done
}

clear
show_title
show_menu

exit 0
# Update depots
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





