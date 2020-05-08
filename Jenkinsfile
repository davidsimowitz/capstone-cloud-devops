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
    options {
        timestamps()
    }
    stages {
        stage('Initialize') {
            steps {
                sh '''
                    chmod +x ./scripts/*.sh
                    docker pull hadolint/hadolint
                '''
            }
        }
        stage('Build Image') {
            steps {
                script {
                    sh './scripts/build-docker-image.sh'
                }
            }
        }
        stage('Tests') {
            parallel {
                stage('Lint HTML') {
                    steps {
                        sh 'tidy -q -e static-html-directory/*.html'
                    }
                }
                stage('Lint Dockerfile') {
                    steps {
                        sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
                    }
                    post {
                        always {
                            sh 'docker rmi hadolint/hadolint'
                        }
                    }
                }
                stage('Security Scan') {
                    environment {
                        AQUA_MICROSCANNER_TOKEN = credentials('aqua-microscanner-token')
                    }
                    steps {
                        script {
                            sh 'MICROSCANNER_TOKEN=$AQUA_MICROSCANNER_TOKEN ./scripts/scan.sh $DOCKER_REPO:$TAG'
                        }
                    }
                }
            }
        }
        stage('Upload Image') {
            steps {
                script {
                    sh './scripts/upload-docker-image.sh'
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
        stage('Deploy Cluster') {
            when {
                beforeInput true
                branch 'master'
            }
            steps{
                withAWS(credentials: 'aws-credentials', region: REGION) {
                    sh './scripts/k8-deploy-cluster.sh'
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
                    sh './scripts/k8-delete-cluster.sh'
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