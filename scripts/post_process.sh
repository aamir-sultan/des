#!/bin/bash

echo_banner "POST PROCESS Setup"

function process_exit_status() {

    script_name=$1
    msg=$2

if [ $? -eq 0 ]; then
    echo "Successfully completed $script_name execution."
    # Continue with the main script here
else
    echo "Error encountered while executing $script_name. $msg"
    # Handle the error scenario or exit the main script
fi
}

# type this in terminal if tmux is already running else this would load the required variables in the shell for plugins installation
tmux source $TMUXCONF_PATH
echo Installing TMUX Plugins
source $TMUX_TPM_PATH/scripts/install_plugins.sh &
wait $! # Install the plugins which are not installed via script and wait for the script to get completed
process_exit_status "install_plugins.sh" "Please Verify that there are no instances of TMUX running or the variables for TMUX are set correctly."
c_echo "yellow" "-------------------------------------------------------------------------------"

echo Cleaning leftover TMUX Plugins
source $TMUX_TPM_PATH/scripts/clean_plugins.sh &
wait $! # Remove plugins that removed from .tmux.conf via script and wait for the script to get completed
process_exit_status "clean_plugins.sh"
c_echo "yellow" "-------------------------------------------------------------------------------"
chdir_to_base