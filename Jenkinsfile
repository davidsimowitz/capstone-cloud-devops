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
        stage('Take Down') {
            steps{
                script {
                    sh 'docker rmi $registry:$version'
                }
            }
        }
    }
}