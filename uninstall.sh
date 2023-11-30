#!/bin/bash

# Define a function for colored echo
c_echo() {
  local color="$1"
  local message="$2"
  local reset="\033[0m"  # Reset to default text color

  case "$color" in
    "red")
      echo -e "\033[31m$message$reset"
      ;;
    "green")
      echo -e "\033[32m$message$reset"
      ;;
    "yellow")
      echo -e "\033[33m$message$reset"
      ;;
    "blue")
      echo -e "\033[34m$message$reset"
      ;;
    "magenta")
      echo -e "\033[35m$message$reset"
      ;;
    "cyan")
      echo -e "\033[36m$message$reset"
      ;;
    *)
      echo "Invalid color. Usage: colored_echo <color> <message>"
      return 1
      ;;
  esac
}

source ./scripts/variables.sh

if [ -f $TOOLBOX/fzf/uninstall ];
then
  source $TOOLBOX/fzf/uninstall
fi

if [ -f ./dotfiles/uninstall.sh ];
then
  source ./dotfiles/uninstall.sh
fi

DIRS=""
DIRS+="$HOME/.local/des "
DIRS+="toolbox "
DIRS+="fonts "
DIRS+="dotfiles "
DIRS+="./bin "


FILES=""
FILES+="*.log "

rm -rf $DIRS $FILES

c_echo "green" "*******************************************************************************"
c_echo "red"   "                              FINISHED Uninstallation" 
c_echo "green" "*******************************************************************************"
