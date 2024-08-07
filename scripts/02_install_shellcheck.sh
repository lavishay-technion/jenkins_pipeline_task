#!/bin/bash

# -----------------------------------------------------------------------------------------------------------------
# This Script installs packages based on Linux distributions.
# Packages: shellcheck, epel-release
# Author: Ori Nahum
# Collaborator: Avishay Layani
# Reference: https://www.cyberciti.biz/programming/improve-your-bashsh-shell-script-with-shellcheck-lint-script-analysis-tool/
# -----------------------------------------------------------------------------------------------------------------

# Check if shellcheck is installed by running 'shellcheck --version'
shellcheck --version > /dev/null

# Check the exit status of the previous command to determine if shellcheck is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install shellcheck based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        # For Debian-based systems (including Ubuntu)
        sudo apt update -y
        sudo apt install -y shellcheck
        echo "[+] shellcheck installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        # For Rocky Linux
        sudo dnf update -y
        sudo dnf -y install epel-release shellcheck
        echo "[+] shellcheck installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        # For Alpine Linux
        sudo apk --no-cache --update add shellcheck
        echo "[+] shellcheck installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi
else 
    echo "[+] shellcheck is already installed"
fi
