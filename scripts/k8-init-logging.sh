#!/usr/bin/env bash

# Describe CloudFormation stack for cluster
eksctl utils describe-stacks --region=$REGION --cluster=$CLUSTER

# Display resource details pre-deployment
kubectl get services
kubectl get nodes