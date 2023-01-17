#!bin/bash

# This script is created for the Master Node in the cluster!

# Get updates
sudo apt update && sudo apt upgrade

# Disable swap
sudo swapoff -a

# From: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ 
# Install Curl
sudo apt-get install -y apt-transport-https ca-certificates curl
# Download the Google Cloud public signing key:
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# Add the Kubernetes apt repository:
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
#Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
# Hold the versions because we do not want to accidentally update your Kubernetes cluster
sudo apt-mark hold kubelet kubeadm kubectl

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Use docker as a non-root user
sudo usermod -aG docker $USER



