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
               stage('Build Package') {
            steps {
                sh """
                chmod +x script/build.sh
                cd script
                ./build.sh
                """
            }
        }
<<<<<<< HEAD

        stage('Publish to Artifactory') {
=======
        stage('Run Docker Container') {
>>>>>>> 68fdaeec544ead4126255efe7a20a1c757eb6475
            steps {
                script {
                    def debFile = sh(script: "ls build-output/*.deb", returnStdout: true).trim()
                    sh """
                    curl -u${ARTIFACTORY_CREDENTIALS_USR}:${ARTIFACTORY_CREDENTIALS_PSW} \
                        -T ${debFile} \
                        ${ARTIFACTORY_URL}/${ARTIFACTORY_REPO}/$(basename ${debFile})
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
    }
}
