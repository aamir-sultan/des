#!/bin/bash
if [ -z ./dotfiles/uninstall.sh ];
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
