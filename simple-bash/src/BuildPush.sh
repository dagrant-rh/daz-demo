#!/bin/bash

read -p "REGISTRY [quay.io]:       " REGISTRY    # e.g. quay.io
read -p "USERNAME [none]:          " USERNAME    
read -p "REPOSITORY [simple-bash]: " REPOSITORY  # e.g. simple-bash
read -p "TAG [latest]:             " TAG         # e.g. 1.4 
read -p "Push to latest? [n]:      " PUSH_TO_LATEST

REGISTRY=${REGISTRY:-quay.io}
USERNAME=${USERNAME:-none}
REPOSITORY=${REPOSITORY:-simple-bash}
TAG=${TAG:-latest}
PUSH_TO_LATEST=${PUSH_TO_LATEST:-N} 
PUSH_TO_LATEST=${PUSH_TO_LATEST^^}

echo -e "\n\nBuilding & pushing: $REGISTRY/$USERNAME/$REPOSITORY:$TAG"
echo -e "Pushing to latest?: $PUSH_TO_LATEST\n\n"

podman build . --format=docker -t $REGISTRY/$USERNAME/$REPOSITORY:$TAG
podman push $REGISTRY/$USERNAME/$REPOSITORY:$TAG

# Already "latest" - No need to tag and push" 
if [[ "$TAG" == "latest" ]]; then
  echo "Skipping, tag has already been pushed as latest ..."
else
  if [[ "$PUSH_TO_LATEST" == "Y" ]]; then
    echo -e "\n\nTagging & pushing $TAG to latest: $REGISTRY/$USERNAME/$REPOSITORY:latest"
    podman tag $REGISTRY/$USERNAME/$REPOSITORY:$TAG $REGISTRY/$USERNAME/$REPOSITORY:latest
    podman push $REGISTRY/$USERNAME/$REPOSITORY:latest
  fi
fi
