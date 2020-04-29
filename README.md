
Develop a CI/CD Pipeline to Roll Out Containerized Microservices Using Rolling Deployment
=========================================================================================


Udacity - Cloud DevOps Engineer Nanodegree
------------------------------------------
Capstone Project: Develop a CI/CD Pipeline to Roll Out Containerized Microservices Using Rolling Deployment


### Capstone Project Overview

As a capstone project, the directions are rather more open-ended than they were in the previous projects in the program. You will also be able to make some of your own choices in this capstone, for the type of deployment you implement, which services you will use, and the nature of the application you develop.

You will develop a CI/CD pipeline for micro services applications with either blue/green deployment or rolling deployment. You will also develop your Continuous Integration steps as you see fit, but must at least include typographical checking (aka “linting”). To make your project stand out, you may also choose to implement other checks such as security scanning, performance testing, integration testing, etc.!

### Project Tasks

Once you have completed your Continuous Integration you will set up Continuous Deployment, which will include:
* Pushing the built Docker container(s) to the Docker repository (you can use AWS ECR, create your own custom Registry within your cluster, or another 3rd party Docker repository) ; and
* Deploying these Docker container(s) to a small Kubernetes cluster. For your Kubernetes cluster you can either use AWS Kubernetes as a Service, or build your own Kubernetes cluster. To deploy your Kubernetes cluster, use either Ansible or Cloudformation. Preferably, run these from within Jenkins as an independent pipeline.


You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2577/view).


## Propose and Scope the Project

* Pipeline:
  + Initializing
  + Lint HTML
  + Build Docker Image
  + Push to Docker Hub
  + Deploy to Cluster
  + Take Down

* Deployment Type:
  + Rolling Deployment

* Docker application:
  + Nginx “Hello World, my name is (student name)” application.


## Use Jenkins, and implement blue/green or rolling deployment.
* Create your Jenkins master box with either Jenkins and install the plugins you will need.
* Set up your environment to which you will deploy code.

## Pick AWS Kubernetes as a Service, or build your own Kubernetes cluster.
* Use Ansible or CloudFormation to build your “infrastructure”; i.e., the Kubernetes Cluster.
* It should create the EC2 instances (if you are building your own), set the correct networking settings, and deploy software to these instances.
* As a final step, the Kubernetes cluster will need to be initialized. The Kubernetes cluster initialization can either be done by hand, or with Ansible/Cloudformation at the student’s discretion.

## Build your pipeline
* Construct your pipeline in your GitHub repository.
* Set up all the steps that your pipeline will include.
* Configure a deployment pipeline.
* Include your Dockerfile/source code in the Git repository.
* Include with your Linting step both a failed Linting screenshot and a successful Linting screenshot to show the Linter working properly.

## Test your pipeline
* Perform builds on your pipeline.
* Verify that your pipeline works as you designed it.
* Take a screenshot of the Jenkins pipeline showing deployment and a screenshot of your AWS EC2 page showing the newly created (for blue/green) or modified (for rolling) instances. Make sure you name your instances differently between blue and green deployments.


Requirements
============

* [Git](https://git-scm.com/downloads) is installed.
* [Python 3](https://www.python.org/downloads/) is installed.
* [Pip](https://pip.pypa.io/en/stable/installing/) is installed.
* [Jenkins](https://www.jenkins.io/doc/book/installing/) is installed and configured correctly.
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) is installed.
* [Docker](https://docs.docker.com/engine/install/ubuntu/) is installed and configured.
* [Docker Hub](https://hub.docker.com/) Account for image repository.
* The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) is installed and configured.
* The [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html) is installed.
* The [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed.
* [eksctl - the official CLI tool for Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed.
* [The Tidy HTML linter](https://www.w3.org/People/Raggett/tidy/) is installed.
