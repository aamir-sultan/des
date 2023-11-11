#! /bin/bash

if [ -z "$EXTRAS_RCLIB" ]; then
# Set the DOTFILES path to the this script and one step beyond.
    EXTRAS_RCLIB="$DOTFILES/../extras/rc_lib"
fi

source $EXTRAS_RCLIB/fzf.rc # fuzzy finder setup