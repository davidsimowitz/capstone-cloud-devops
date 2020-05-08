#!/usr/bin/env bash

# Upload docker image to docker registry
docker login --username $DOCKER_CREDS_USR --password $DOCKER_CREDS_PSW
docker push $DOCKER_REPO:$TAG
