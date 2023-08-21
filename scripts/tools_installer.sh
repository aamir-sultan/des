#!/bin/bash

# Cloning toolbox for des to work
source $SCRIPTS/get_tools.sh

# creating symlinks for tools from toolbox directory

# Set the file name
file_name="$TOOLS_CONFIG"

# Read the file
yaml_data=$(yq -r . "$file_name")
tools=$(yq '.tools[].*.name | ..' $file_name)

# Parse the YAML data
for key in $tools; do

  src_path=$(yq ".tools[].$key.paths[].src" $file_name)
  dst_path=$(yq ".tools[].$key.paths[].dst" $file_name)
  src_file=$(yq ".tools[].$key.filename" $file_name)
  src_path=$(echo $src_path | sed 's/null//' | sed 's/ //g')
  dst_path=$(echo $dst_path | sed 's/null//' | sed 's/ //g')
  src_file=$(echo $src_file | sed 's/null//' | sed 's/ //g')

  src_path=$(eval "echo $src_path")
  dst_path=$(eval "echo $dst_path")

  # Check if the target directory exists
  if [[ ! -d "$dst_path" ]]; then
    mkdir -p "$dst_path"
  fi

 # # Check if the file exists
 if [ -f "$dst_path/$key" ]; then
   echo "$key already available at $dst_path. Skiping symbolic linking"
   mv $dst_path/$key $dst_path/$key.bak
   echo "$key already available at $dst_path. $dst_path/$key is backuped to $dst_path/$key.bak"
   echo "Symbolic linking $key from $src_path/$src_file to $dst_path/$key"
   ln -s $src_path/$src_file $dst_path/$key
 else
  echo "Symbolic linking $key from $src_path/$src_file to $dst_path/$key"
  ln -s $src_path/$src_file $dst_path/$key
 fi
done
