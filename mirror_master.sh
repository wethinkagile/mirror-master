#!/bin/bash

# Usage
function usage() {
  echo -e "\nDescription: This script uses skopeo to sync 2 docker registries please be sure to have the following text file in place:"
  echo -e "\nimage-list.txt\n"
  exit 1
}

while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
done < images-list.txt


# Function
function copy_image() {
    skopeo sync --all --src docker --dest docker $source_registry/$i:$n $dest_registry/
}
