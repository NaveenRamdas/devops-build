pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker_id_some') // Jenkins credentials ID
        DEV_REPO = "naveen21r/development"
        PROD_REPO = "naveen21r/production"
    }
    triggers {
        // Triggers the pipeline for changes in both development and main branches
        githubPush()
    }
    stages {
        stage('Checkout') {
            steps {
                // Pull the latest code
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
        stage('Push Docker Image to Dev') {
            when {
                branch 'development'
            }
            steps {
                script {
                    docker.withRegistry('', 'docker_id_some') {
                        def image = docker.image("${DEV_REPO}:${env.BUILD_ID}")
                        image.push()
                    }
                }
            }
        }
        stage('Push Docker Image to Prod') {
            when {
                branch 'main'
            }
            steps {
                script {
                    docker.withRegistry('', 'docker_id_some') {
                        def image = docker.image("${PROD_REPO}:${env.BUILD_ID}")
                        image.push()
                    }
                }
            }
        }
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                // Here, add deployment logic if necessary
                echo "Deploying ${PROD_REPO}:${env.BUILD_ID} to production server"
            }
        }
    }
}
