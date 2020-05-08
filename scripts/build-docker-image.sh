#!/usr/bin/env bash

# Build docker image
docker build -t $DOCKER_REPO:$TAG .
