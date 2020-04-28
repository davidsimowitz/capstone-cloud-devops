#!/usr/bin/env bash
# This file builds, tags, and uploads an image to Docker Hub

# Build image and set a tag
docker build -t cloud-devops-capstone-project .

# Create dockerpath
dockerpath=cloud-devops-capstone-project

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username davidsimowitz
docker tag cloud-devops-capstone-project davidsimowitz/cloud-devops-capstone-project:1.0

# Step 3:
# Push image to a docker repository
docker push davidsimowitz/cloud-devops-capstone-project:1.0