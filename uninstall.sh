#!/bin/bash

source ./dotfiles/uninstall.sh
DIRS=""
DIRS+="$HOME/.local/des "
DIRS+="toolbox "
DIRS+="fonts "
DIRS+="dotfiles "


FILES=""
FILES+="*.log "

rm -rf $DIRS $FILES
