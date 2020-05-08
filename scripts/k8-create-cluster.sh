#!/usr/bin/env bash

eksctl create cluster \
 --name $CLUSTER \
 --region $REGION \
 --zones us-east-1a us-east-1b us-east-1c us-east-1d \
 --version 1.15 \
 --nodegroup-name workers \
 --node-ami auto \
 --node-type t2.medium \
 --nodes 2 \
 --nodes-min 1 \
 --nodes-max 2
