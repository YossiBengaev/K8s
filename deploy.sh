#!/bin/bash

docker_run(){
    echo "running docker run to my web-app... "
    ssh -o StrictHostKeyChecking=no master@${IP_MACHINE} 'docker run -d --name web-app $DockerHubRegistry:latest'
}

copy_to_remote_machine() {
    echo "starting copy Helm Dir to Master...."
    scp -o StrictHostKeyChecking=no ${FILES_TO_COPY} master@${IP_MACHINE}:${HOME_DIR} 
}

run_helm_yossi_ingress(){
    echo "starting deploy ingress.. "
    ssh -o StrictHostKeyChecking=no master@${IP_MACHINE} 'helm install yossi-ingress Helm-yossi-ingress'
}

docker_run
copy_to_remote_machine 
run_helm_yossi_ingress

FILES_TO_COPY="Helm-yossi-ingress"
IP_MACHINE="192.168.56.104"
HOME_DIR="/home/master"
