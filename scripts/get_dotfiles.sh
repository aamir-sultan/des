#!/bin/bash

DIR=$DOTFILES

# Check if the source directory exists
if [[ ! -d "$DIR" ]]; then
  echo "The dotfiles directory does not exist."
  git clone https://github.com/aamir-sultan/dotfiles.git
  #exit 1
else
  cd $DIR
  echo "Updating $DIR."
  git pull
fi

