#!/usr/bin/env bash

./k8-create-cluster.sh
./get-docker-image.sh
./k8-deploy-cluster.sh

