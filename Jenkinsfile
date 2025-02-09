pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "chandan3461/healthcare-app:latest"
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
        stage('Deploy to Kubernetes') {
            steps {
                script{
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'SA_Kubernetes_Master', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f namespace.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'namespace.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false), sshPublisherDesc(configName: 'SA_Kubernetes_Master', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f deployment.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'deployment.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false), sshPublisherDesc(configName: 'SA_Kubernetes_Master', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f service.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '.', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'service.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                }
            }
        }
    }
}
