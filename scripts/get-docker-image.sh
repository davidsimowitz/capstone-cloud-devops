#!/usr/bin/env bash

# Pull image from docker registry
docker login --username $DOCKER_CREDS_USR --password $DOCKER_CREDS_PSW
docker pull $DOCKER_REPO:$TAG
