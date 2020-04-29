
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




Project Details
===============


## Pipeline Deployment


### Initializing Stage:
![Jenkins pipeline initializing stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-initializing-stage.png)


### Lint HTML Stage:
![Jenkins pipeline lint html stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-lint-html-stage.png)


### Build Docker Image Stage:
![Jenkins pipeline build docker image stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-build-docker-image-stage.png)


### Push to Docker Hub Stage:
![jenkins pipeline push to docker hub stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-push-to-docker-hub-stage.png)


### Deploy to Cluster Stage:
![Jenkins pipeline deploy to cluster stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-deploy-to-cluster-stage.png)


### Take Down Stage:
![Jenkins pipeline take down stage](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-take-down-stage.png)




Linting Stage Verification
==========================


## HTML Linting Check Catches Invalid HTML Tag:

![jenkins pipeline lint html stage fail](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-lint-html-stage-fail.png)


## HTML Linting Check Passes Corrected HTML Tag:

![jenkins pipeline lint html stage pass](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/jenkins-pipeline-lint-html-stage-pass.png)




Deployment Type
===============


## Rolling Deployment


* Deployment Logs:
```bash
+ kubectl get services
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP                                                              PORT(S)          AGE
capstone-project-elb   LoadBalancer   10.100.77.85   ac84e215e577d4eb9a6fa4ac3d7708a6-229427463.us-east-1.elb.amazonaws.com   8080:32092/TCP   4h25m
kubernetes             ClusterIP      10.100.0.1     <none>                                                                   443/TCP          4h43m
+ kubectl get pods -o wide
NAME                                             READY   STATUS    RESTARTS   AGE     IP               NODE                             NOMINATED NODE   READINESS GATES
cloud-devops-capstone-project-7ff8ff4c6f-2k8h4   1/1     Running   0          4h25m   192.168.15.201   ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-58v9w   1/1     Running   0          4h25m   192.168.48.46    ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-6b5qj   1/1     Running   0          4h25m   192.168.50.176   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-9sbr4   1/1     Running   0          4h25m   192.168.31.21    ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-c8tp6   1/1     Running   0          4h25m   192.168.56.227   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-jz5z9   1/1     Running   0          4h25m   192.168.59.12    ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-mr6mf   1/1     Running   0          4h25m   192.168.11.249   ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-qqvnr   1/1     Running   0          4h25m   192.168.3.228    ip-192-168-31-109.ec2.internal   <none>           <none>
+ kubectl apply --filename=k8-deployment-config.yml
deployment.apps/cloud-devops-capstone-project configured
service/capstone-project-elb unchanged
+ kubectl get services
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP                                                              PORT(S)          AGE
capstone-project-elb   LoadBalancer   10.100.77.85   ac84e215e577d4eb9a6fa4ac3d7708a6-229427463.us-east-1.elb.amazonaws.com   8080:32092/TCP   4h25m
kubernetes             ClusterIP      10.100.0.1     <none>                                                                   443/TCP          4h43m
+ kubectl get pods -o wide
NAME                                             READY   STATUS              RESTARTS   AGE     IP               NODE                             NOMINATED NODE   READINESS GATES
cloud-devops-capstone-project-54cb4855b6-5v967   1/1     Running             0          2s      192.168.19.119   ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-54cb4855b6-7j5bt   0/1     ContainerCreating   0          2s      <none>           ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-54cb4855b6-gjdkh   1/1     Running             0          2s      192.168.63.222   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-54cb4855b6-hgdql   1/1     Running             0          2s      192.168.60.141   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-2k8h4   1/1     Running             0          4h25m   192.168.15.201   ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-58v9w   1/1     Running             0          4h25m   192.168.48.46    ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-6b5qj   1/1     Running             0          4h25m   192.168.50.176   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-c8tp6   0/1     Terminating         0          4h25m   192.168.56.227   ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-jz5z9   1/1     Running             0          4h25m   192.168.59.12    ip-192-168-32-247.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-mr6mf   1/1     Running             0          4h25m   192.168.11.249   ip-192-168-31-109.ec2.internal   <none>           <none>
cloud-devops-capstone-project-7ff8ff4c6f-qqvnr   1/1     Running             0          4h25m   192.168.3.228    ip-192-168-31-109.ec2.internal   <none>           <none>

```


### Deployment Services and Pod Details Before and After Deployment to Cluster

![rolling deployment services and pod details](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/rolling-deployment-services-and-pod-details.png)


### EKS Cluster

![eks cluster general info](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/eks-cluster.png)


### CloudFormation Stack Info - EKS Cluster

![eks cluster stack info](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/eks-cluster-stack-info.png)


### CloudFormation Events - EKS Cluster

![eks cluster events](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/eks-cluster-events.png)


### CloudFormation Resources - EKS Cluster

![eks cluster resources](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/eks-cluster-resources.png)




Docker application:
===================


## Nginx "Hello World, my name is (student name)" application.
* I used an [nginx image](https://hub.docker.com/_/nginx), specifically the alpine tag - [nginx:stable-alpine](https://github.com/nginxinc/docker-nginx/blob/70e44865208627c5ada57242b46920205603c096/stable/alpine/Dockerfile):
  + This image is based on the popular Alpine Linux project, available in the alpine official image. Alpine Linux is much smaller than most distribution base images (approx. 5MB), and thus leads to much slimmer images in general.


## Docker Hub Repository
![docker hub repo](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/docker-hub-repo.png)


## [Application Link](http://ac84e215e577d4eb9a6fa4ac3d7708a6-229427463.us-east-1.elb.amazonaws.com:8080/)
  + http://ac84e215e577d4eb9a6fa4ac3d7708a6-229427463.us-east-1.elb.amazonaws.com:8080/

![application](https://github.com/davidsimowitz/capstone-cloud-devops/blob/master/images/application.png)




Requirements
============


* [Git](https://git-scm.com/downloads) is installed.
* [Python 3](https://www.python.org/downloads/) is installed.
* [Pip](https://pip.pypa.io/en/stable/installing/) is installed.
* [Jenkins](https://www.jenkins.io/doc/book/installing/) is installed and configured correctly.
* [Docker](https://docs.docker.com/engine/install/ubuntu/) is installed and configured.
* [Docker Hub](https://hub.docker.com/) Account for image repository.
* The Kubernetes command-line tool, [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) is installed and configured.
* The [AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html) is installed.
* The [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed.
* [eksctl - the official CLI tool for Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) is installed.
* [The Tidy HTML linter](https://www.w3.org/People/Raggett/tidy/) is installed.




Configuration
=============


* Software dependencies are installed.
* Set up IAM credentials in AWS.
* Launch EC2 Instance for Jenkins box and configure.
* Install Jenkins and configure.
* Verify `Blue Ocean` plugin is installed in Jenkins.
* Verify `Docker` plugin is installed in Jenkins.
* Verify `Pipeline: AWS Steps` plugin is installed in Jenkins.
* Set up a GitHub Repository.
* Add GitHub credentials to Jenkins.
* Add Docker Hub credentials to Jenkins.
* Add AWS credentials to Jenkins.
* Configure AWS CLI credentials.
* Use the [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) script.
* Create the Amazon EKS cluster.
  + This was accomplished by running the `k8_cluster_initializer.sh` script.
* Update the Amazon EKS cluster once its creation is complete.
  + This was accomplished by running the `k8_cluster_constructor.sh` script.
* Add Pipeline.




References
==========


* [Using a Jenkinsfile](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)
* [End-to-End Multibranch Pipeline Project Creation](https://www.jenkins.io/doc/tutorials/build-a-multibranch-pipeline-project/)
* [nginx documentation](http://nginx.org/en/docs/)
* [nginx image](https://hub.docker.com/_/nginx):
* [nginx:stable-alpine tag](https://github.com/nginxinc/docker-nginx/blob/70e44865208627c5ada57242b46920205603c096/stable/alpine/Dockerfile)
* [Docker Installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
* [Docker Pipeline](https://plugins.jenkins.io/docker-workflow/)
* [Pushing docker images to Docker Hub](https://appfleet.com/blog/building-docker-images-to-docker-hub-using-jenkins-pipelines/)
* [Installing kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
* [Overview of kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
* [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Kubernetes API Reference Docs for Deployment v1 apps](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#deployment-v1-apps)
* [Interacting with running pods](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#interacting-with-running-pods)
* [eksctl - The official CLI for Amazon EKS](https://eksctl.io/)
* [Amazon EKS Workshop](https://eksworkshop.com/010_introduction/)
* [Getting started with eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)
* [Installing eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
* [Installing aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
* [Managing users or IAM roles for your cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
* [How To Authenticate to AWS with the Pipeline AWS Plugin](https://support.cloudbees.com/hc/en-us/articles/360027893492-How-To-Authenticate-to-AWS-with-the-Pipeline-AWS-Plugin)
* [Jenkins Pipeline Step Plugin for AWS](https://github.com/jenkinsci/pipeline-aws-plugin)
* [Amazon EKS cluster endpoint access control](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html)
* [Create a kubeconfig for Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
* [Creating an Amazon EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)
* [Kubernetes LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer)
* [Troubleshoot Service Load Balancers for Amazon EKS](https://aws.amazon.com/premiumsupport/knowledge-center/eks-load-balancers-troubleshooting/)
