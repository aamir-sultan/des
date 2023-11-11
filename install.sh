#!/bin/bash

source ./path_exports.sh
export PATH=$PATH:$TOOLBOX/yq

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

c_echo "green" "*******************************************************************************"
c_echo "red"   "                              DOTFILES Installation" 
c_echo "green" "*******************************************************************************"
source $DOTFILES_CLONER
source $DOTFILES_INSTALLER
c_echo "green" "*******************************************************************************"
c_echo "red"   "                              TOOLs Installation" 
c_echo "green" "*******************************************************************************"
# Its in working form. Just commented as it is not required in most environments.
# source $FONTS_INSTALLER
source $TOOLS_CLONER
source $EXTRA_SETUP
c_echo "green" "*******************************************************************************"
source $TOOLS_INSTALLER
c_echo "green" "*******************************************************************************"
c_echo "red"   "                              FINISHED Installation" 
c_echo "green" "*******************************************************************************"

# source $CLEANUP
