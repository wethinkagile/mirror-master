#!/bin/bash

if [ -e "images-list.txt" ]; then
    echo -e "\n # Found images-list.txt"
else
   echo -e "\n # Please be sure to have the following text file in\
 place: images-list.txt\n"
   exit 1
fi

# Checking Variables
if [ -z "$DEST_REGISTRY" ] ; then
  echo -e "\n# DEST_REGISTRY variable empty or missing\n"
  exit 1
fi

if [ -z "$SOURCE_REGISTRY" ] ; then
  echo -e "\n# SOURCE_REGISTRY variable empty or missing/n"
  exit 1
fi

echo -e " # Proceeding with LOGIN to $SOURCE_REGISTRY\n"
podman login $SOURCE_REGISTRY

echo -e " # Proceeding with LOGIN to $DEST_REGISTRY\n"
podman login $DEST_REGISTRY

# Displaying Configuration
echo -e " # Source Registry: $SOURCE_REGISTRY \n # Destination Registry: $DEST_REGISTRY \n"

while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
  skopeo copy docker://$SOURCE_REGISTRY/$p docker://$DEST_REGISTRY/$p --dest-tls-verify=false
done < images-list.txt
