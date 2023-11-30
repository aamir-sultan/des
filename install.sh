#!/bin/bash


# set -u # Good for catching issues in scripts where you might have uninitialized variables.

prefix='~/.des'
prefix_expand=~/.des

fonts=0
dotfiles=1
tools=1
whose_use=0
br_name="main"

help() {
  cat << EOF
usage: $0 [OPTIONS]

    --help               Show this message
    --all                Download and Install everything that is supported
    --xdg                Generate files under \$XDG_CONFIG_HOME/.des (Not
                         supported right now)
    --[no-]fonts         Enable/disable fonts cloning and installation
    --[no-]dotfiles      Enable/disable dotfiles cloning and installation
    --[no-]tools         Enable/disable tools cloning and installation

    --dev                Use the development branch for fonts, dotfiles and
                         toolbox
    --my-br              Use the my branch for fonts, dotfiles and toolbox
    --main               Use the main branch for fonts, dotfiles and toolbox

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
    --dev)             whose_use=2
                       br_name="dev-br"
      ;;
    --my-br)           whose_use=1
                       br_name="my-br"
      ;;
    --main)            whose_use=0
                       br_name="main"
      ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

function set_des_base() {
cd "$(dirname "${BASH_SOURCE[0]}")"
DES_PATH=$(pwd)
DES_PATH_ESC=$(printf %q "$DES_PATH")

# echo DES_PATH set to $DES_PATH

# Keep variables in start as other files are using it so when they are source sometime the variable is not available.
for file in $DES_PATH/scripts/{variables,functions,path,exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
}

set_des_base

c_echo "green" "*******************************************************************************"
c_echo "red"   "                              DOTFILES Installation" 
c_echo "green" "*******************************************************************************"
source $DOTFILES_CLONER
echo_pwd
source $DOTFILES_INSTALLER
echo_pwd
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
