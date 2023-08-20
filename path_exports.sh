# DES_PATH=`pwd`
# Check if the DES_PATH is not set
if [ -z "$DES_PATH" ]; then
# Set the DES_PATH path to this script.
    DES_PATH="$(cd "$(dirname "$0")" && pwd)"
fi

TOOLBOX="$DES_PATH/toolbox"
SCRIPTS="$DES_PATH/scripts"
CONFIGS="$DES_PATH/configs"
DOTFILES="$DES_PATH/dotfiles"



TOOLS_CONFIG="$CONFIGS/tools.config.yaml"
TOOLS_INSTALLER="$SCRIPTS/tools_installer.sh"

# Path for fonts
FONTS_SRC="$DES_PATH/fonts"
FONTS_DEST="$HOME/.fonts"
FONTS_INSTALLER="$SCRIPTS/fonts_installer.sh"

# Path for dotfiles
DOTFILES_CLONER="$SCRIPTS/get_dotfiles.sh"
DOTFILES_INSTALLER="$SCRIPTS/dotfiles_installer.sh"

# Cleanup script path
CLEANUP="$SCRIPTS/cleanup.sh"

# uninstall script path
UNINSTALL="$DES_PATH/uninstall.sh"


echo -e "================================================================="
echo -e "DES_PATH     path: $DES_PATH"
echo -e "SCRIPTS      path: $SCRIPTS"
echo -e "CONFIGS      path: $CONFIGS"
echo -e "TOOLBOX      path: $TOOLBOX"
echo -e "TOOL_CONFIG  path: $TOOLS_CONFIG"
echo -e "FONTS_SRC    path: $FONTS_SRC"
echo -e "FONTS_DEST   path: $FONTS_DEST"
echo -e "=================================================================\n"
