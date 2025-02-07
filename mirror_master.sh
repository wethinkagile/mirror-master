#!/bin/bash

# Usage
function usage() {
  echo -e "\nDescription: This script uses skopeo to sync 2 docker registries please be sure to have the following text file in place:"
  echo -e "\nimage-list.txt\n"
  exit 1
}


# Checking Variables
if [ -z "$dest_registry" ] ; then
  echo -e "DEST_REGISTRY variable empty or missing"
  usage;
fi

if [ -z "$source_registry" ] ; then
  echo -e "SOURCE_REGISTRY variable empty or missing"
  usage;
fi


# Displaying Configuration
echo -e "\n Source Registry: $source_registry \n Destination Registry: $dest_registry \n"


while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
  copy_image($p)
done < images-list.txt


# Function
function copy_image($image) {
    # skopeo copy docker://$source_registry/$image docker://$dest_registry/$image
}
