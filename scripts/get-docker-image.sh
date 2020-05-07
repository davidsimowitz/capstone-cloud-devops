#!/usr/bin/env bash

# Pull image from docker repository
docker login --username davidsimowitz
docker pull davidsimowitz/cloud-devops-capstone-project:$TAG
