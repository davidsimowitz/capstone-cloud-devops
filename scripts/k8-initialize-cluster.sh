#!/usr/bin/env bash

./scripts/k8-create-cluster.sh
./scripts/get-docker-image.sh
./scripts/k8-deploy-cluster.sh

