#!/bin/bash

if [ $fonts -eq 1 ]; then
  echo_banner "FONTS Installation"

  source $SCRIPTS/get_fonts.sh
  if [ -z ${FONTS_SRC+x} ]; then
    if [ -z ${1+x} ]; then
      echo "The variable FONTS_SRC is not defined. Pass the source dir path for fonts as first argument to the script"
      echo "e.g.: ./fonts_installer ~/fonts"
    else
      FONTS_SRC=$1
    fi
  else
    # echo "The variable FONTS_SRC is defined."
    # Set the source directory path
    src_dir=$FONTS_SRC
  fi

  if [ -z ${FONTS_DEST+x} ]; then
    echo "The variable FONTS_DEST is not defined. Defaulting to ~/.fonts"
    FONTS_DEST=~/.fonts
  else
    # echo "The variable FONTS_DEST is defined."
    # Set the target directory path
    dst_dir=$FONTS_DEST
  fi

  # Check if the source directory exists
  if [[ ! -d "$src_dir" ]]; then
    echo "The source directory does not exist."
    exit 1
  fi

  # Check if the target directory exists
  if [[ ! -d "$dst_dir" ]]; then
    mkdir "$dst_dir"
  fi

  # Copy the fonts
  for f in "$src_dir"/*.ttf; do
    cp "$f" "$dst_dir"
  done

  # Success message
  echo "Fonts copied successfully."
  chdir_to_base
fi
