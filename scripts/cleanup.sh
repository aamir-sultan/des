#!/bin/bash

DIRS=""
DIRS+="fonts "
DIRS+="toolbox "
# DIRS+="dotfiles "

FILES=""
FILES+="*.log "

echo "Cleaning up $DIRS $FILES"
rm -rf $DIRS $FILES
