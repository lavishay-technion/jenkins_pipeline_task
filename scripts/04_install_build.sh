#!/bin/bash

# -----------------------------------------------------------------------------------------------------------------
# This Script installs Docker and Docker Compose based on Linux distributions.
# Packages: docker, docker-ce, docker-ce-cli, containerd.io, docker-compose
# Additional dependencies: dnf-plugins-core (Rocky), apt-transport-https, ca-certificates, curl, gnupg, lsb-release (Debian/Ubuntu)
# Reference: https://docs.docker.com/engine/install/
# -----------------------------------------------------------------------------------------------------------------

# Check if Docker is installed by running 'docker --version'
docker --version > /dev/null

# Check the exit status of the previous command to determine if Docker is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install Docker based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        # For Debian-based systems (including Ubuntu)
        sudo apt update
        sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
        echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io
        sudo systemctl start docker
        sudo systemctl enable docker
        echo "Docker version: $(sudo docker --version)"
        echo "[+] Docker installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        # For Rocky Linux
        sudo dnf update -y
        sudo dnf install -y dnf-plugins-core
        sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
        sudo dnf install -y docker-ce docker-ce-cli containerd.io
        sudo systemctl start docker
        sudo systemctl enable docker
        echo "Docker version: $(sudo docker --version)"
        echo "[+] Docker installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        # For Alpine Linux
        sudo apk update
        sudo apk add docker
        sudo rc-update add docker boot
        sudo service docker start
        echo "Docker version: $(sudo docker --version)"
        echo "[+] Docker installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi
else
    echo "[+] Docker is already installed"
fi

# Check if Docker Compose is installed by running 'docker compose version'
docker compose version > /dev/null

# Check the exit status of the previous command to determine if Docker Compose is installed
if [[ $? != 0 ]]; then
    # Install Docker Compose
    DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo usermod -aG docker $USER
    echo "Docker Compose version: $(sudo docker-compose version)"
    echo "[+] Docker Compose installed"
else
    echo "[+] Docker Compose is already installed"
fi
