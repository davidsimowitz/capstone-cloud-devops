#!/usr/bin/env bash

# Pull image from docker repository
docker login --username davidsimowitz
docker pull davidsimowitz/cloud-devops-capstone-project

# Deploy to initialized Amazon EKS cluster
kubectl apply --filename=k8-deployment-config.yml
