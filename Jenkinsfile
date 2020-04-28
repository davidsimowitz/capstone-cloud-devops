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
        stage('Build Docker Image') {
            steps {
                sh '''
                    echo $USER
                    docker build -t cloud-devops-capstone-project .
                    docker image ls
                '''
            }
        }
    }
}