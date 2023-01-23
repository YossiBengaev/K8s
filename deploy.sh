#!/bin/bash

# Global Variables
RepoDockerHub='yossibenga/web-app:latest'
MasterDir='/home/master'
IngressFolder='Helm-yossi-ingress'
IngressName='yossi-ingress'

docker_run() {
    echo "starting run docker...."
    ssh -o StrictHostKeyChecking=no "master@master" "docker run -d $RepoDockerHub"
}

copy_to_remote_machine() {
    echo "starting copy Helm Dir to Master...."
    scp -r "$IngressFolder" "master@master":"$MasterDir" 
}

run_helm_yossi_ingress() {
    echo "starting deploy ingress..."
    ssh -o StrictHostKeyChecking=no "master@master" "helm uninstall $IngressName ;
     kubectl delete namespace mission ; kubectl create namespace mission ;
     helm install $IngressName $IngressFolder"
}

echo "starting deploy my web-app container and then deployment and ingress of K8s on Master node"

docker_run
copy_to_remote_machine 
run_helm_yossi_ingress


