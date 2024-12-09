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
                ls -R
                chmod +x script/build.sh
                cd script
                ./build.sh
                """
            }
        }
        stage('Publish to Artifactory') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'artifactory-docker-creds', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]){

                      def debFile = sh(script: "ls build-output/*.deb", returnStdout: true).trim()
                      sh """
                      curl -k -u ${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -XPUT \
                       "https://devopsdarshan7.jfrog.io/artifactory/darshu-debian-local/main/s/sampleproject/${debFile};deb.distribution=stable;deb.component=main;deb.architecture=amd64"  \
                        -T ${debFile} 
                    """
                    }
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
