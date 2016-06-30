#!/bin/bash

#Some color codes
RED='\033[1;31m'
GRN='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
CYN='\033[1;36m'
DEF='\033[0m'
DIV=${RED}#${GRN}#${BLU}#
DIV=${DIV}${DIV}${DIV}${DIV}${DIV}${DIV}${DIV}
DIV=$DIV$DIV$DIV$DIV
DIV=\\n${DIV}\\n${DIV}\\n\\n${CYN}
echo -e $DIV
echo -e "Installing Douglas Innovation Air Column OS"
echo -e "Hold on to your hat!"

#MUST BE SUDO
if [[ $UID != 0 ]]; then
	echo -e "${RED}You must be sudo to run this script"
	echo -e "${DEF}sudo $0 $*"
	exit 1
fi

#######################
# CHANGE KEYBOARD TO  #
# ENGLISH (US) LAYOUT #
#######################
echo -e "${DIV}Changing keyboard layout to ENGLISH (US)${DEF}"
sudo sed -i 's|XKBLAYOUT=....|XKBLAYOUT="en"|g' /etc/default/keyboard

################
# Update repos #
################
echo -e "${DIV}Updating repositories$DEF"
sudo apt-get update

###############
# INSTALL VIM #
###############
echo -e "${DIV}Installing VIM${DEF}"
sudo apt-get install -y vim

###############
# INSTALL GIT #
###############
echo -e "${DIV}Installing GIT${DEF}"
sudo apt-get install -y git

################
# INSTALL JAVA #
################
echo -e "${DIV}Installing Java and tools$DEF"
sudo apt-get install -y oracle-java8-jdk

###############
# INSTALL FBI #
###############
echo -e "${DIV}Installing FBI$DEF"
sudo apt-get install -y fbi

######################
# INSTALL C Compiler #
######################
echo -e "${DIV}Installing GCC and MAKE$DEF"
sudo apt-get install -y gcc g++ make

#################
# SPLASH SCREEN #
#################
echo -e "${DIV}Setting up splash screen$DEF"
sudo cp 00S0asplashscreen /etc/init.d/00S0asplashscreen
sudo cp splash.png /etc/splash.png
sudo chmod a+x /etc/init.d/00S0asplashscreen
sudo insserv /etc/init.d/00S0asplashscreen

##################
# REMOVE RAINBOW #
##################
echo -e "${DIV}Removing startup rainbow splash screen$DEF"
sudo sed -i "s/disable_splash=./disable_splash=1/g" /boot/config.txt
#If grep finds the string, don't execute the next part.
#If not found, add it to the file
grep -q -F "disable_splash=1" /boot/config.txt || sudo echo -e "\ndisable_splash=1" >> /boot/config.txt

####################
# HIDE RAS-PI LOGO #
####################
echo -e "${DIV}Removing Raspberry Pi Logo on startup$DEF"
grep -q -F "logo.nologo" /boot/cmdline.txt || sudo sed -i "s/$/ logo.nologo/" /boot/cmdline.txt

############################
# DISALLOW STARTUP LOGGING #
############################
echo -e "${DIV}Disallowing programs to display output during startup$DEF"
grep -q -F "loglevel=1" /boot/cmdline.txt || sudo sed -i "s/$/ loglevel=1/" /boot/cmdline.txt

##########################
# FORWARD CONSOLE OUTPUT #
##########################
echo -e "${DIV}Sending startup text to a different terminal (tty3)$DEF"
sudo sed -i "s/console=tty1/console=tty3/g" /boot/cmdline.txt

#################
# ROTATE SCREEN #
#################
echo -e "${DIV}Rotating screen 270 degrees$DEF"
sudo sed -i "s/#*display_rotate=./display_rotate=3/g" /boot/config.txt
grep -q -F "display_rotate=3" /boot/config.txt || echo -e "\ndisplay_rotate=3" >> /boot/config.txt

echo -e "${DIV}Everything is done!   Please Reboot$DEF"
