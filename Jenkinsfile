pipeline {
    environment {
            registry = "davidsimowitz/cloud-devops-capstone-project"
            registryCredential = 'DockerHubID'
            version = "1.1"
            dockerImage = ''
            CLUSTER_NAME = 'microservice'
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
            options {
                retry(2)
            }
            steps {
                script {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                        sh '''
                            chmod +x ./scripts/*.sh
                            ./scripts/get-docker-image.sh
                            ./scripts/k8-initialize-cluster.sh
                        '''
                    }
                }
            }
            post {
                success {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                        sh './scripts/k8-init-logging.sh'
                    }
                }
            }
        }
        stage('Deploy to Cluster') {
            when {
                beforeInput true
                branch 'master'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh './scripts/k8-deploy-cluster.sh'
                }
            }
            post {
                success {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                        sh './scripts/k8-deployment-logging.sh'
                    }
                }
                failure {
                    withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                        sh './scripts/k8-deployment-error-logging.sh'
                    }
                }
            }
        }
        stage('Delete Cluster') {
            when {
                beforeInput true
                branch 'tear-down-cluster'
            }
            options {
                retry(3)
            }
            input {
                message 'Warning, about to delete cluster...'
                ok 'Continue with cluster deletion.'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: 'us-east-1') {
                    sh './scripts/k8-delete-cluster.sh'
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