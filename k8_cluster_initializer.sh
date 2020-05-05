#!/usr/bin/env bash

eksctl create cluster \
 --name microservice \
 --region us-east-1 \
 --version 1.15 \
 --nodegroup-name workers \
 --node-ami auto \
 --node-type t2.medium \
 --nodes 2 \
 --nodes-min 1 \
 --nodes-max 2