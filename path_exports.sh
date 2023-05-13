DES_PATH=`pwd`

TOOLBOX="$DES_PATH/toolbox"
SCRIPTS="$DES_PATH/scripts"
CONFIGS="$DES_PATH/configs"



TOOLS_CONFIG="$CONFIGS/tools.config.yaml"
TOOLS_INSTALLER="$SCRIPTS/tools_installer.sh"

# Path for fonts
FONTS_SRC="$DES_PATH/fonts"
FONTS_DEST="$HOME/.fonts"
FONTS_INSTALLER="$SCRIPTS/fonts_installer.sh"

echo -e "================================================================="
echo -e "DES_PATH     path: $DES_PATH"
echo -e "SCRIPTS      path: $SCRIPTS"
echo -e "CONFIGS      path: $CONFIGS"
echo -e "TOOLBOX      path: $TOOLBOX"
echo -e "TOOL_CONFIG  path: $TOOLS_CONFIG"
echo -e "FONTS_SRC    path: $FONTS_SRC"
echo -e "FONTS_DEST   path: $FONTS_DEST"
echo -e "=================================================================\n"
