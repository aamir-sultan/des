#!/bin/bash

source ./path_exports.sh
export PATH=$PATH:$TOOLBOX/yq

# set -u

prefix='~/.des'
prefix_expand=~/.des

fonts=0
dotfiles=1
tools=1
whose_use=0

help() {
  cat << EOF
usage: $0 [OPTIONS]

    --help               Show this message
    --all                Download and Install everything that is supported
    --xdg                Generate files under \$XDG_CONFIG_HOME/.des
    --[no-]fonts         Enable/disable fonts cloning and installation
    --[no-]dotfiles      Enable/disable dotfiles cloning and installation
    --[no-]tools         Enable/disable tools cloning and installation

    --dev                Clone the development branch for fonts, dotfiles and
                         toolbox
    --my-br              Clone the my branch for fonts, dotfiles and toolbox
    --main               Clone the main branch for fonts, dotfiles and toolbox

EOF
}

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0
      ;;
    --all)
      fonts=1
      dotfiles=1
      tools=1
      ;;
    --xdg)
      prefix='"${XDG_CONFIG_HOME:-$HOME/.config}"/.des'
      prefix_expand=${XDG_CONFIG_HOME:-$HOME/.config}/.des
      mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/.des"
      ;;
    --fonts)           fonts=1    ;;
    --no-fonts)        fonts=0    ;;
    --dotfiles)        dotfiles=1 ;;
    --no-dotfiles)     dotfiles=0 ;;
    --tools)           tools=1    ;;
    --no-tools)        tools=0    ;;
    --dev)             whose_use=0;;
    --my-br)           whose_use=1;;
    --main)            whose_use=2;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

cd "$(dirname "${BASH_SOURCE[0]}")"
fzf_base=$(pwd)
fzf_base_esc=$(printf %q "$fzf_base")

ask() {
  while true; do
    read -p "$1 ([y]/n) " -r
    REPLY=${REPLY:-"y"}
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      return 1
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
      return 0
    fi
  done
}

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
c_echo "red"   "                              POST PROCESS Setup" 
c_echo "green" "*******************************************************************************"
source $POST_PROCESS
c_echo "green" "*******************************************************************************"
c_echo "red"   "                              FINISHED Installation" 
c_echo "green" "*******************************************************************************"

# source $CLEANUP
