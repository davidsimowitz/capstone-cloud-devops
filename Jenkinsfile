pipeline {
    environment {
            registry = "davidsimowitz/cloud-devops-capstone-project"
            registryCredential = 'DockerHubID'
            version = "1.1"
            dockerImage = ''
        }
    agent any
    stages {
        stage('Initializing') {
            steps {
                sh 'echo "Initializing Jenkins Pipeline..."'
            }
        }
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e static-html-directory/*.html'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":" + version
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Create Cluster') {
            when {
                beforeInput true
                branch 'initialize-cluster'
            }
            input {
                message 'Proceed with cluster creation?'
                ok 'Yes, create cluster.'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh '''
                        ./k8_cluster_initializer.sh
                        ./k8_cluster_constructor.sh

                        # Display services and pod detail post-deployment
                        kubectl get services
                        kubectl get pods -o wide
                    '''
                }
            }
        }
        stage('Deploy to Cluster') {
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh '''
                        # Display services and pod detail pre-deployment
                        kubectl get services
                        kubectl get pods -o wide

                        kubectl apply --filename=k8-deployment-config.yml

                        # Display services and pod detail post-deployment
                        kubectl get services
                        kubectl get pods -o wide
                    '''
                }
            }
        }
        stage('Delete Cluster') {
            when {
                beforeInput true
                branch 'tear-down-cluster'
            }
            input {
                message 'Warning, about to delete cluster...'
                ok 'Continue with cluster deletion.'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh '''
                        # Display services and pod detail pre-deployment
                        kubectl get services
                        kubectl get pods -o wide

                        #./k8_cluster_deletion.sh
                        eksctl delete cluster --name microservice

                        # Display services and pod detail post-deployment
                        kubectl get services
                        kubectl get pods -o wide
                    '''
                }
            }
        }
    }
    post {
        cleanup {
            sh 'docker rmi $registry:$version'
        }
    }
}