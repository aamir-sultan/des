
# # Installing Fuzzy Finder in toolbox
# DIR="$TOOLBOX/fzf"
# if [[ -d "$DIR" ]]; then
#   echo $DIR already available 
# else
#   echo Working on $(basename $DIR) ...
#   case $(basename $DIR) in
     
#     fzf)
#         git clone --depth 1 https://github.com/junegunn/fzf.git $TOOLBOX/fzf
#         $TOOLBOX/fzf/install --key-bindings --completion --no-update-rc
#         mv ~/.fzf.bash $TOOLOX/fzf/.fzf.bash
#         ;;
#    esac
# fi

#! /bin/bash

if [ ! -f $EXTRA_ANCHOR_PATH ]; then
  if [ ! -d $DOTFILES_EXTRAS ]; then
    echo Creating extras dir at $DOTFILES_EXTRAS
    mkdir -p $DOTFILES_EXTRAS
  fi
  echo Creating extra setup file at $EXTRA_ANCHOR_PATH
  touch $EXTRA_ANCHOR_PATH
  echo -e "#! /bin/bash\n" >> $EXTRA_ANCHOR_PATH
  echo "source $EXTRA_SRC_PATH" >> $EXTRA_ANCHOR_PATH
else
  echo Setup file for extra already exists 
fi


# Fields=("git_url, path, hash_or_branch, clone_switches, install_switches/install_command")
extras=(
  "fzf, https://github.com/junegunn/fzf.git, $TOOLBOX/fzf,  master, --depth 1, ./install --key-bindings --completion --no-update-rc; mv ~/.fzf.bash $TOOLBOX/fzf/.fzf.bash"
  # "tvip_common, https://github.com/taichi-ishitani/tvip-common.git, tvip-common, d3641c7992260d0eae651f02c9778fe65eba6a9e"
)

for ((i=0; $i < ${#extras[*]}; i++)) do
  echo -------------------------------------------------------------------------------
  temp=(${extras[$i]})
  echo "Array elements: ${temp[@]}"
  IFS=, read -ra repo_info <<< "${extras[$i]}"

  name=${repo_info[0]}
  url=${repo_info[1]}
  path=${repo_info[2]}
  hash=${repo_info[3]}
  clone_switches=${repo_info[4]}
  install_command=${repo_info[5]}

  echo "Name: $name"
  echo "URL: $url"
  echo "Path: $path"
  echo "Hash: $hash"
  echo "Clone switches: $clone_switches"
  echo "Install command: $install_command"
  echo -------------------------------------

  # Cloning setup
  if [ ! -d $path ]; then
    git clone $clone_switches $url $path 
  else
    echo -e "\n$name Already available at $path"
  fi

  echo Entering $path
  cd $path; git fetch; git checkout $hash

  # Installing setup
  if [ ! -z "$install_command" ]; then
    eval $install_command
  fi

  echo -------------------------------------------------------------------------------
done

cd $DES_PATH
echo Back to $(pwd)


