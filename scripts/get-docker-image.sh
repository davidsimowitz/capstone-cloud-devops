#!/usr/bin/env bash

# Pull image from docker repository
docker login --username davidsimowitz
docker pull $DOCKER_REPO:$TAG
