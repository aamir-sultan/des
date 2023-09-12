#!/bin/bash

DIR=$FONTS_SRC

# Check if the source directory exists
if [[ ! -d "$DIR" ]]; then
  echo "The $DIR directory does not exist."
  git clone --depth 1 https://github.com/aamir-sultan/fonts.git
  #exit 1
else
  cd $DIR
  echo "Updating $DIR."
  git pull
fi

