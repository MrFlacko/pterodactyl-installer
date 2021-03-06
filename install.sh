#!/bin/bash

set -e

#############################################################################
#                                                                           #
# Project 'pterodactyl-installer'                                           #
#                                                                           #
# Copyright (C) 2018 - 2020, Vilhelm Prytz, <vilhelm@prytznet.se>, et al.   #
#                                                                           #
#   This program is free software: you can redistribute it and/or modify    #
#   it under the terms of the GNU General Public License as published by    #
#   the Free Software Foundation, either version 3 of the License, or       #
#   (at your option) any later version.                                     #
#                                                                           #
#   This program is distributed in the hope that it will be useful,         #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of          #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           #
#   GNU General Public License for more details.                            #
#                                                                           #
#   You should have received a copy of the GNU General Public License       #
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.  #
#                                                                           #
# https://github.com/vilhelmprytz/pterodactyl-installer/blob/master/LICENSE #
#                                                                           #
# This script is not associated with the official Pterodactyl Project.      #
# https://github.com/vilhelmprytz/pterodactyl-installer                     #
#                                                                           #
#############################################################################

# This defines the version of the script. It allows me to easily keep track of it when I'm testing the script from GitHub
Script_Version="0.8"

# Some colours that are used throughout the script
LIGHT_RED='\033[1;31m'
RED='\033[0;31m'
LIGHT_BLUE='\033[0;96m'
BLUE='\033[1;34m'
DARK_GRAY='\033[0;37m'
LIGHT_GREEN='\033[1;32m'
NoColor='\033[0m'

# Global Variables
Panel="https://raw.githubusercontent.com/MrFlacko/pterodactyl-installer/master/install-panel.sh"
Wings="https://raw.githubusercontent.com/MrFlacko/pterodactyl-installer/master/install-wings.sh"

# Check if the script can be ran
[[ $EUID -ne 0 ]] && echo -e ""$RED"Error: Please run this script with root privileges (sudo)"$NoColor"" && exit 1
[[ ! -x "$(command -v curl)" ]] && echo -e ""$RED"This script needs curl. Please install it to continue."$NoColor"" && exit 1
#[[ -z $(echo $os_version | grep 'Ubuntu 20') ]] && echo -e ""$RED"Error: This script must be ran with Ubuntu 20.04"$NoColor"" && exit 1

OpeningMessage() {
  echo -e "\n${BLUE}Pterodactyl Installation Script ${DARK_GRAY}($Script_Version)"
  echo -e "Forked from Vilhelmprytz\n"
  echo -e "${LIGHT_GREEN}Hello,"
  echo "This script was designed to quickly run through the Pterodactyl" 
  echo "install with as much ease to the user as possible."
  echo "This script is a bit of a redesign of the one from Vilhelmprytz."
  echo "The last one did a few things that I found a bit annoying so I just"
  echo "decided to make this one."
  echo -e "Best of luck - Flacko \n"
  echo ''
  echo -e "${NoColor} What would you like to do?"
  echo -e "${LIGHT_BLUE}[1] ${DARK_GRAY}Panel and Wings Installation"
  echo -e "${LIGHT_BLUE}[2] ${DARK_GRAY}Just Panel Installation"
  echo -e "${LIGHT_BLUE}[3] ${DARK_GRAY}Just Wings Installation"  
  echo -e "${NoColor}"

  while true
    do
      read -p 'Please type 1-3: ' OpeningOption
      [[ "$OpeningOption" == "1" ]] && loading_bar && bash <(curl -s $Panel) && bash <(curl -s $Wings) && exit 0
      [[ "$OpeningOption" == "2" ]] && loading_bar && bash <(curl -s $Panel) && exit 0
      [[ "$OpeningOption" == "3" ]] && loading_bar && bash <(curl -s $Wings) && exit 0
    done
}

# This is a visual loading bar funcation obtained from https://unix.stackexchange.com/questions/415421/linux-how-to-create-simple-progress-bar-in-bash
function loading_bar {
  clear
  prog() {
      local w=80 p=$1;  shift
      # create a string of spaces, then change them to dots
      printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /.};
      # print those dots on a fixed-width space plus the percentage etc. 
      printf "\r\e[K|%-*s| %3d %% %s" "$w" "$dots" "$p" "$*"; 
  }
  # test loop
  for x in {1..100} ; do
      prog "$x" 
      sleep .05   # do some work here
  done ; echo
  clear
}

main() {
  clear
  OpeningMessage
  exit 0
}

main
