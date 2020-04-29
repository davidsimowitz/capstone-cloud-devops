pipeline {
    environment {
            registry = "davidsimowitz/cloud-devops-capstone-project"
            registryCredential = 'DockerHubID'
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
                    dockerImage = docker.build registry + ":1.0"
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
        stage('Deploy to Cluster') {
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh './k8_cluster_initializer.sh'
                }
            }
        }
        stage('Take Down') {
            steps{
                script {
                    sh 'docker rmi $registry:1.0'
                }
            }
        }
    }
}