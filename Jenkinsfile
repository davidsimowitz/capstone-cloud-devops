pipeline {
    environment {
            registry = "davidsimowitz/cloud-devops-capstone-project"
            registryCredential = 'DockerHub_ID'
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
                dockerImage = docker.build registry + ":1.0"
            }
        }
        stage('Push to Docker Hub') {
            steps {
                docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
            }
        }
    }
}