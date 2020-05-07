pipeline {
    environment {
            DOCKER_IMAGE = ''
            TAG = "1.1"
            DOCKER_REPO = "davidsimowitz/cloud-devops-capstone-project"
            DOCKER_CREDS = credentials('docker-hub-credentials')

            K8_CONFIG_FILE = 'k8-deployment-config.yml'
            CLUSTER = 'microservice'
            REGION = 'us-east-1'
        }
    agent any
    stages {
        stage('Initializing') {
            steps {
                sh 'echo "Initializing Jenkins Pipeline..."'
            }
        }
        stage('Parallel Tests') {
            parallel {
                stage('Lint HTML') {
                    steps {
                        sh 'tidy -q -e static-html-directory/*.html'
                    }
                }
                stage('Lint Dockerfile') {
                    steps {
                        sh '''
                            docker pull hadolint/hadolint
                            docker run --rm -i hadolint/hadolint < Dockerfile
                        '''
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    DOCKER_IMAGE = docker.build(DOCKER_REPO + ":" + TAG)
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry( '', 'docker-hub-credentials' ) {
                        DOCKER_IMAGE.push(TAG)
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
                    withAWS(credentials: 'aws-credentials', region: REGION) {
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
                    withAWS(credentials: 'aws-credentials', region: REGION) {
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
                withAWS(credentials: 'aws-credentials', region: REGION) {
                    sh '''
                        chmod +x ./scripts/*.sh
                        ./scripts/k8-deploy-cluster.sh
                    '''
                }
            }
            post {
                success {
                    withAWS(credentials: 'aws-credentials', region: REGION) {
                        sh './scripts/k8-deployment-logging.sh'
                    }
                }
                failure {
                    withAWS(credentials: 'aws-credentials', region: REGION) {
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
                retry(2)
            }
            input {
                message 'Warning, about to delete cluster...'
                ok 'Continue with cluster deletion.'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: REGION) {
                    sh '''
                        chmod +x ./scripts/*.sh
                        ./scripts/k8-delete-cluster.sh
                    '''
                }
            }
        }
    }
    post {
        cleanup {
            sh 'docker rmi $DOCKER_REPO:$TAG'
        }
    }
}