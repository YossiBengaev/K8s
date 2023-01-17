#!bin/bash

# This is for all the Nodes in the cluster

 # Get updates
sudo apt update -y

# Disable swap
sudo swapoff -a
sed -i '/swap/d' /etc/fstab

# Install Curl
sudo apt-get install -y apt-transport-https ca-certificates curl

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Use docker as a non-root user
sudo usermod -aG docker $USER

# Enable docker service
systemctl enable docker >/dev/null 2>&1
systemctl start docker

# From: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ 
# Download the Google Cloud public signing key:
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
#Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
# Hold the versions because we do not want to accidentally update your Kubernetes cluster
sudo apt-mark hold kubelet kubeadm kubectl



