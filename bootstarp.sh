#!bin/bash

# This is for all the Nodes in the cluster

 # Get updates
sudo apt update && sudo apt upgrade

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
