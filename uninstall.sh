#!/bin/bash

source ./dotfiles/uninstall.sh
DIRS=""
DIRS+="$HOME/.local/des "
DIRS+="toolbox "
DIRS+="fonts "
DIRS+="dotfiles "
DIRS+="./bin "


FILES=""
FILES+="*.log "

rm -rf $DIRS $FILES
