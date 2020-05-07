#!/usr/bin/env bash

chmod +x ./scripts/*.sh

./scripts/k8-create-cluster.sh
./scripts/k8-deploy-cluster.sh

