#!/usr/bin/env bash

# Build docker image
docker build -t $DOCKER_REPO:$TAG --build-arg=token=$AQUA_MICROSCANNER_TOKEN --no-cache .
