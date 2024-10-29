pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker_id_some') // Update with Jenkins credentials ID
        DEV_REPO = "naveen21r/development"
        PROD_REPO = "naveen21r/production"
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Branch: ${env.BRANCH_NAME}"
                }
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/NaveenRamdas/devops-build.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with a specific tag
                    def imageTag = "${env.BRANCH_NAME}-${env.BUILD_ID}"
                    docker.build("${DEV_REPO}:${imageTag}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker_id_some') {
                        def repo = env.BRANCH_NAME == 'development' ? DEV_REPO : PROD_REPO
                        def image = docker.image("${repo}:${env.BUILD_ID}")
                        image.push()
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                branch 'development'
            }
            steps {
                // Here, add deployment logic if necessary
                echo "Deploying ${PROD_REPO}:${env.BUILD_ID} to production server"
            }
        }
    }
}
