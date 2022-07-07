#!/bin/bash

# Uncomment and set the following environment variables.

#REGISTRY="<registry eg. quay.io>"
#USERNAME="<registry username>"
#REPOSITORY="simple-bash"
#TAG="1.0"

[[ -z "$REGISTRY" ]] && echo "REGISTRY is not defined!" && exit 1
[[ -z "$USERNAME" ]] && echo "REGISTRY is not defined!" && exit 1
[[ -z "$REPOSITORY" ]] && echo "REGISTRY is not defined!" && exit 1
[[ -z "$TAG" ]] && echo "REGISTRY is not defined!" && exit 1

echo -e "\n\nBuilding & pushing: $REGISTRY/$USERNAME/$REPOSITORY:$TAG\n\n"

podman build . --format=docker -t $REGISTRY/$USERNAME/$REPOSITORY:$TAG
podman push $REGISTRY/$USERNAME/$REPOSITORY:$TAG

podman tag $REGISTRY/$USERNAME/$REPOSITORY:$TAG $REGISTRY/$USERNAME/$REPOSITORY:latest
podman push $REGISTRY/$USERNAME/$REPOSITORY:latest


