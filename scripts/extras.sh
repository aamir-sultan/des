#! /bin/bash

echo_banner "Resolving Dependencies"

if [ ! -f $EXTRA_ANCHOR_PATH ]; then
  if [ ! -d $DOTFILES_EXTRAS ]; then
    echo Creating extras dir at $DOTFILES_EXTRAS
    mkdir -p $DOTFILES_EXTRAS
  fi
  echo Creating extra setup file at $EXTRA_ANCHOR_PATH
  touch $EXTRA_ANCHOR_PATH
  echo -e "#! /bin/bash\n" >>$EXTRA_ANCHOR_PATH
  echo "source $EXTRA_SRC_PATH" >>$EXTRA_ANCHOR_PATH
else
  echo Setup file for extra already exists
fi

# Version of the binaries which should work in any normal place
# Fields=("name, url, dload_path, dload_tool, dload_switches, post_process_cmds")
extra_bins=(
  # Hard code the version of the nvim to remove in any version change related issues.
  # "nvim, https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "nvim, https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "fd, https://github.com/sharkdp/fd/releases/download/v8.7.1/fd-v8.7.1-i686-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "bat, https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-i686-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "vivid, https://github.com/sharkdp/vivid/releases/download/v0.9.0/vivid-v0.9.0-x86_64-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  # "uctags, https://github.com/universal-ctags/ctags-nightly-build/releases/download/2023.12.03%2B684ed1d057eef7dd5b81a2d3a7576f96d4a827b9/uctags-2023.12.03-linux-x86_64.tar.xz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xf dfile"
)

# Use the tools which are supported on the server side libraries
# Fields=("name, url, dload_path, dload_tool, dload_switches, post_process_cmds")
extra_bins_ssh=(
  "nvim, https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "fd, https://github.com/sharkdp/fd/releases/download/v8.7.1/fd-v8.7.1-i686-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  "bat, https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-i686-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  # "vivid, https://github.com/sharkdp/vivid/releases/download/v0.9.0/vivid-v0.9.0-x86_64-unknown-linux-musl.tar.gz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xzf dfile"
  # "uctags, https://github.com/universal-ctags/ctags-nightly-build/releases/download/2023.12.03%2B684ed1d057eef7dd5b81a2d3a7576f96d4a827b9/uctags-2023.12.03-linux-x86_64.tar.xz, $TOOLBOX, wget, --directory-prefix=$TOOLBOX, tar xf dfile"
)

# Fields=("git_url, path, hash_or_branch, clone_switches, install_switches/install_command")
extras=(
  "fzf, https://github.com/junegunn/fzf.git, $TOOLBOX/fzf,  master, --depth 1, ./install --key-bindings --completion --no-update-rc; mv ~/.fzf.bash $TOOLBOX/fzf/.fzf.bash"
  # "tvip_common, https://github.com/taichi-ishitani/tvip-common.git, tvip-common, d3641c7992260d0eae651f02c9778fe65eba6a9e"
)

for ((i = 0; $i < ${#extras[*]}; i++)); do
  echo -------------------------------------------------------------------------------
  temp=(${extras[$i]})
  echo "Array elements: ${temp[@]}"
  IFS=, read -ra repo_info <<<"${extras[$i]}"

  name=${repo_info[0]}
  url=${repo_info[1]}
  path=${repo_info[2]}
  hash=${repo_info[3]}
  clone_switches=${repo_info[4]}
  install_command=${repo_info[5]}

  echo "Name:              $name"
  echo "URL:              $url"
  echo "Path:             $path"
  echo "Hash:             $hash"
  echo "Clone switches:   $clone_switches"
  echo "Install command:  $install_command"
  echo -------------------------------------

  # Cloning setup
  if [ ! -d $path ]; then
    git clone $clone_switches $url $path
    echo Entering $path
    cd $path
    git fetch
    git checkout $hash
    # Installing setup
    if [ ! -z "$install_command" ]; then
      eval $install_command
    fi
  else
    echo -e "\n$name Already available at $path"
  fi

  cd -
  echo -------------------------------------------------------------------------------
done

# Use the tools which are supported on the server side libraries
if [[ "${SSH_TTY}" ]]; then
  binaries=("${extra_bins_ssh[@]}")
else
  binaries=("${extra_bins[@]}")
fi

for ((i = 0; $i < ${#binaries[*]}; i++)); do
  echo -------------------------------------------------------------------------------

  # Use the tools which are supported on the server side libraries
  temp=(${binaries[$i]})
  echo "Array elements: ${temp[@]}"
  IFS=, read -ra bin_info <<<"${binaries[$i]}"

  name=${bin_info[0]}
  url=${bin_info[1]}
  dload_path=${bin_info[2]}
  # file_extension are related to dload_path and used in the following commands
  filename=$(basename "$url")

  # dload_tool=${bin_info[3]}

  if command -v ${bin_info[3]} >/dev/null 2>&1; then
    echo "Using $dload_tool to download the file."
    dload_tool=${bin_info[3]}
  elif command -v curl >/dev/null 2>&1; then
    echo "Using curl to download the file."
    dload_tool=curl
  else
    echo "Error: Neither ${bin_info[3]} nor curl is available on this system."
    exit 1
  fi

  dload_switches=${bin_info[4]}
  post_proc_cmd=${bin_info[5]}

  setup_path=$dload_path/$name
  file_path=$dload_path/$filename

  echo "Name:                      $name"
  echo "URL:                      $url"
  echo "Filename:                  $filename"
  echo "Download Path:            $dload_path"
  echo "Download tool:            $dload_tool"
  echo "Download switches:        $dload_switches"
  echo "Post Processing command:  $post_proc_cmd"
  echo "Setup Path:               $setup_path"
  echo "File Path:                $file_path"
  echo -------------------------------------------

  # Cloning setup
  if [ ! -d $setup_path ]; then
    if [ ! -f $file_path ]; then
      $dload_tool $url $dload_switches
    fi
    cd $dload_path
    mv $filename dfile
    echo "Entered $(pwd)"

    # Installing setup
    if [ ! -z "$post_proc_cmd" ]; then
      eval $post_proc_cmd
      mv $name* $name
    fi
    rm -rf dfile $filename

  else
    echo -e "\n$name Already available at $dload_path"
  fi

  cd -
  echo -------------------------------------------------------------------------------
done

cd $DES_PATH
echo Back to $(pwd)
