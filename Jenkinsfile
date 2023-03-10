pipeline {
    agent any
    environment {
        DockerHubRegistry = 'yossibenga/web-app'
        DockerHubUrl = 'https://hub.docker.com/repository/docker/yossibenga/web-app'
        DockerImage = 'yossibenga/web-app'
        DockerHubRegistryCredential  = 'DockerHubCred'
        
        JenkinsDir = '/var/lib/jenkins/workspace/k8'
        JenkinsWorkSpace = '/var/lib/jenkins/workspace'
    }

    stages {
        stage('Build') {
            steps {
                echo '# # # # # STAGE 1 -> Starting Build stage... # # # # #'
                script {
                    dir('App'){
                        dockerImage = docker.build("$DockerHubRegistry:latest")
                    }
                }
            }
        }
        stage('Push To DockerHub') {
            steps {
                echo '# # # # # STAGE 2 -> Starting Push To DockerHub stage... # # # # #'
                script {
                    withDockerRegistry([ credentialsId: "$DockerHubRegistryCredential", url: "" ]) {
                    dockerImage.push()
                    sh 'docker rmi $DockerHubRegistry:latest'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo '# # # # # STAGE 3 -> Starting Deploy ... # # # # #'
                script {
                        sshagent(['MasterSshCred']) {
                            sh 'cp $JenkinsWorkSpace/known_hosts $JenkinsDir'
                            sh 'chmod u+x $JenkinsDir/deploy.sh'
                            sh 'bash deploy.sh'
                        }
                }
            }
        }
    }
}
