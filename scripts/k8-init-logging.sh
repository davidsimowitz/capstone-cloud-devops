#!/usr/bin/env bash

# Describe CloudFormation stack for cluster
eksctl utils describe-stacks --region=us-east-1 --cluster=microservice

# Display resource details pre-deployment
kubectl get services
kubectl get nodes