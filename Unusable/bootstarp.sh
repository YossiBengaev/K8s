#!/bin/bash

# This is for all the nodes in the cluster

 # Get updates
 echo "Geting updates...."
sudo apt update -y

# Disable swap
echo "Disable swap"
sudo swapoff -a
sed -i '/swap/d' /etc/fstab

# Install curl
echo "Install curl"
sudo apt install curl -y

# Install curl
echo "Install net-tools"
sudo apt install net-tools -y

# Install Docker
echo "Install docker..."
sudo apt-get install ca-certificates -y curl -y gnupg -y lsb-release -y
sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Use docker as a non-root user
sudo usermod -aG docker $USER

echo "Install Kubernetes..."
# From: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ 
# Download the Google Cloud public signing key:
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
#Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
# Hold the versions because we do not want to accidentally update your Kubernetes cluster
sudo apt-mark hold kubelet kubeadm kubectl

#if [[ $USER = "kmaster" ]] 
#then    chmod 777 master.sh && bash master.sh
#elif [[ $USER = "kworker*" ]]
#then    chmod 777 worker.sh && bash worker.sh
#fi
