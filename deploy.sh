#!/bin/bash

docker_run(){
    echo "running docker... "
    ssh -o StrictHostKeyChecking=no "master@master" 'docker run -d yossibenga/web-app:latest'
}

copy_to_remote_machine() {
    echo "starting copy Helm Dir to Master...."
    scp -r "Helm-yossi-ingress" "master@master":"/home/master" 
}

run_helm_yossi_ingress(){
    echo "starting deploy ingress.. "
    ssh -o StrictHostKeyChecking=no "master@master" 'helm install yossi-ingress Helm-yossi-ingress'
}

docker_run
copy_to_remote_machine 
run_helm_yossi_ingress

FILES_TO_COPY="Helm-yossi-ingress"
IP_MACHINE="192.168.56.104"
HOME_DIR="/home/master"
