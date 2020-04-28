#!/usr/bin/env bash

# Build image and set a tag
docker build -t cloud-devops-capstone-project .

# List docker images
docker image ls

# Run application
docker run -p 8080:80 cloud-devops-capstone-project