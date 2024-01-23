#!/bin/bash
set -e

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install necessary tools: vmtools, curl, ssh
apt-get update
apt-get install -y open-vm-tools openssh-server ca-certificates curl gnupg lsb-release
ufw allow ssh

# Install kubectl
KUBECTL_URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "$KUBECTL_URL"
if [ $? -ne 0 ]; then
    echo "Failed to download kubectl"
    exit 1
fi
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Kind
KIND_URL="https://kind.sigs.k8s.io/dl/v0.13.0/kind-linux-amd64"
curl -Lo ./kind "$KIND_URL"
chmod +x ./kind
mv ./kind /usr/local/bin/kind

# Install Docker
if ! command -v docker > /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
fi

# Add user to the docker group
if [ $(getent group docker) ]; then
    echo "docker group exists."
else
    groupadd docker
fi

usermod -aG docker $USER
echo "Please log out and log back in to apply Docker group changes."

# Final status checks or summary
echo "Installation complete."
echo "Installed tools: vmtools, curl, ssh, kubectl, kind, Docker"

systemctl restart docker
su - $USER
