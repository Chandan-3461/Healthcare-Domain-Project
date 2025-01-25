pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_SECRET_KEY_ID') // Replace with the Jenkins credential ID for AWS Access Key
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') // Replace with the Jenkins credential ID for AWS Secret Key
    }
    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Chandan-3461/Healthcare-Domain-Project', branch: 'master'
            }
        }
        stage('Build Code') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t chandan3461/healthcare-app:latest .'
            }
        }
        stage('Login to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerpass', variable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u chandan3461 --password-stdin
                    '''
                }
                echo 'Logged in to DockerHub'
            }
        }
        stage('Publish the Image to DockerHub') {
            steps {
                echo 'Pushing Docker image to DockerHub'
                sh 'docker push chandan3461/healthcare-app:latest'
            }
        }
        stage('Terraform Init and Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

