pipeline {
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
        stage('Build docker image') {
            steps {
                sh '''
                    docker build -t cloud-devops-capstone-project .
                    docker image ls
                '''
            }
        }
    }
}