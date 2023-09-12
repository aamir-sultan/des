#!/bin/bash

DIR=$TOOLBOX

# Check if the source directory exists
if [[ ! -d "$DIR" ]]; then
  echo "The $DIR directory does not exist. Cloning toolbox."
  git clone --depth 1 https://github.com/aamir-sultan/toolbox.git
  #exit 1
else
  cd $DIR
  echo "Updating $DIR."
  git pull
fi

