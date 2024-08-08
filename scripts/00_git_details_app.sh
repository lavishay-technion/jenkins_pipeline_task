#!/bin/bash

# ----------------------------------------------------------------------------------------------------------
# This Script checks if Git is installed and clones/pulls the Details_App repo from GitHub to /tmp/Details_App.
# If Git is not installed, it checks the OS and installs Git accordingly.
# Packages: GIT
# ----------------------------------------------------------------------------------------------------------

# Check if Git is installed by running 'git --version'
git --version

# Check the exit status of the previous command to determine if Git is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install Git based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        # For Debian-based systems (including Ubuntu)
        sudo apt-get update -y
        sudo apt-get -y install git
        echo "[+] Git installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        # For Rocky Linux
        sudo dnf update -y
        sudo dnf --enablerepo=crb -y install git
        echo "[+] Git installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        # For Alpine Linux
        sudo apk --no-cache --update add git
        echo "[+] Git installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi
else
    echo "[+] Git is already installed"
fi
    
# Define the application directory
APP_DIR="/tmp/Details_App"

# Check if the directory /tmp/Details_App does not exist
if [[ ! -d $APP_DIR ]]; then
    # Clone the Details_App repository into the directory
    git clone https://github.com/orinahum/Details_App.git $APP_DIR
    echo "[+] Project Details App successfully cloned"
else
    # Pull the latest changes in the existing repository
    git -C $APP_DIR pull
    echo "[+] Project Details App successfully updated"
fi
