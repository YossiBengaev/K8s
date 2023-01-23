#!/bin/bash

# Global Variables
RepoDockerHub='yossibenga/web-app:latest'
MasterDir='/home/master'
HelmFolder='Helm-yossi-ingress'
HelmName='yossi-ingress'

docker_run() {
    echo "starting run docker..."
    ssh -o StrictHostKeyChecking=no "master@master" "docker run -d $RepoDockerHub"
}

copy_to_remote_machine() {
    echo "starting copy Helm Dir to Master...."
    scp -r "$HelmFolder" "master@master":"$MasterDir" 
}

run_helm() {
    echo "starting deploy Helm..."
    ssh -o StrictHostKeyChecking=no "master@master" "helm uninstall $HelmName ;
     kubectl delete namespace mission ; kubectl create namespace mission ;
     helm install $HelmName $HelmFolder"
}

echo "starting deploy with Helm my web-app Application and deploy resources on K8s Cluster..."

docker_run
copy_to_remote_machine 
run_helm


