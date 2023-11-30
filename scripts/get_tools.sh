#!/bin/bash

if [ $tools -eq 1 ]; then
  echo_banner "TOOLs Installation"

  DIR=$TOOLBOX

  # Check if the source directory exists
  if [[ ! -d "$DIR" ]]; then
    # echo "The $DIR directory does not exist. Cloning toolbox."
    git clone -b $br_name --depth 1 https://github.com/aamir-sultan/toolbox.git
    #exit 1
  else
    cd $DIR
    # echo "Updating $DIR."
    echo "Branch to be used $br_name."

    # Take the correct branch name for repo on which it is currently.
    # https://stackoverflow.com/a/1593487/16941779
    repo_br_name=$(git symbolic-ref -q HEAD)
    repo_br_name=${repo_br_name##refs/heads/}
    repo_br_name=${repo_br_name:-HEAD}

    if [[ "$repo_br_name" == "$br_name" ]]; then
      echo "Updating $br_name branch for $DIR..."
      git pull
    else 
      echo "Checking out $DIR repo to $br_name branch.."
      git checkout $br_name  
    
    # Check again if the branch is successfully checked out
      repo_br_name=$(git symbolic-ref -q HEAD)
      repo_br_name=${repo_br_name##refs/heads/}
      repo_br_name=${repo_br_name:-HEAD}

      if [[ "$repo_br_name" == "$br_name" ]]; then
        echo "Updating $br_name branch for $DIR..."
        git pull
      else
        echo "ERROR: $br_name branch for $DIR couldn't not be updated"
        exit 1
      fi

    fi
  fi

  echo_sep
  chdir_to_base
fi
