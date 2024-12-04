pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'devopsdarshan7.jfrog.io'
        IMAGE_NAME = 'darshu-docker-local/debian:bullseyedev'
    }
    stages {
        stage('Login to Artifactory') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'artifactory-docker-creds', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                        sh """
                        docker login -u $ARTIFACTORY_USER -p $ARTIFACTORY_PASSWORD $DOCKER_REGISTRY
                        """
                    }
                }
            }
        }
        stage('Pull Docker Image') {
            steps {
                sh """
                docker pull $DOCKER_REGISTRY/$IMAGE_NAME
                """
            }
        }
        stage('Run Docker Container') {
            when { buildingTag() }
            steps {
                sh """
                docker run -d $DOCKER_REGISTRY/$IMAGE_NAME
                """
            }
        }
    }
}
