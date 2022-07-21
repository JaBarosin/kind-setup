#!/bin/bash
# Notes on setting up k8s v2 demo VM
#
# username = 	demo
# pw =		bit9se# 
#
# Install necessary tools:
# - vmtools
# - curl
# - ssh
#
# Install k8s demo utilities
# - kubectl
# - kind
# - Docker
#
# Create kind cluster

apt update -y
apt install open-vm-tools -y
apt update && sudo apt upgrade -y


# Install curl
apt install curl -y

# Install banner tools
apt install figlet toilet -y

#Install ssh
apt update
apt install openssh-server -y
ufw allow ssh

#Copy script from host to vm and run as user 'demo'

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# If needed w/o root.
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl

# Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.13.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind

# Install Docker
apt-get remove docker docker-engine docker.io containerd runc -y

apt-get update
apt-get install \
    ca-certificates \ki
    curl \
    gnupg \
    lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
groupadd docker
usermod -aG docker $USER

# login to new user session to refresh new group changes
su - $USER

# create cluster
kind create cluster --name k8s-demo-01
