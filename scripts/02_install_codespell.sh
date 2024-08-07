#!/bin/bash

# -----------------------------------------------------------------------------------------------------------------
# This Script installs packages based on Linux distributions.
# Packages: python3-pip, py3-pip, codespell
# Author: Ori Nahum
# Collaborator: Avishay Layani
# References:
# - https://linuxcommandlibrary.com/man/codespell
# - https://rhel.pkgs.org/9/epel-x86_64/codespell-2.2.1-1.el9.noarch.rpm.html
# -----------------------------------------------------------------------------------------------------------------

# Check if codespell is installed by running 'codespell --version'
codespell --version > /dev/null

# Check the exit status of the previous command to determine if codespell is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install codespell based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        # For Debian-based systems (including Ubuntu)
        sudo apt-get update -y
        sudo apt-get install -y apt-utils codespell
        echo "[+] codespell installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        # For Rocky Linux
        sudo dnf update -y
        sudo dnf install -y python3-pip
        pip3 install codespell
        echo "[+] codespell installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        # For Alpine Linux
        sudo apk --no-cache --update add py3-pip
        pip3 install codespell
        echo "[+] codespell installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi
else
    echo "[+] codespell is already installed"
fi
