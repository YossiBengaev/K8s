#!/bin/bash

# Global Variables
RepoDockerHub='yossibenga/web-app:latest'
MasterDir='/home/master'
IngressFolder='Helm-yossi-ingress'
IngressName='yossi-ingress'

docker_run(){
    echo "running docker... "
    ssh -o StrictHostKeyChecking=no "master@master" "docker run -d $RepoDockerHub"
}

copy_to_remote_machine() {
    echo "starting copy Helm Dir to Master...."
    scp -r "$IngressFolder" "master@master":"$MasterDir" 
}

run_helm_yossi_ingress(){
    echo "starting deploy ingress.. "
    ssh -o StrictHostKeyChecking=no "master@master" "helm uninstall $IngressName || helm install $IngressName $IngressFolder"
}

docker_run
copy_to_remote_machine 
run_helm_yossi_ingress


