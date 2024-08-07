#!/bin/bash

# -----------------------------------------------------------------------------------------------------------------
# This Script installs packages based on Linux distributions.
# Packages: python3, python3-pip, py3-pip, poetry
# Author: Ori Nahum
# Collaborator: Avishay Layani
# References:
# - https://docs.pytest.org/en/stable/reference/plugin_list.html
# - https://pytest-html.readthedocs.io/en/latest/installing.html
# -----------------------------------------------------------------------------------------------------------------

# Check if poetry is installed by running 'poetry --version'
poetry --version > /dev/null

# Check the exit status of the previous command to determine if poetry is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install poetry based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt install -y python3-poetry
        echo "[+] poetry installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        sudo dnf update -y
        sudo dnf install -y python3-poetry
        echo "[+] poetry installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        sudo apk --no-cache --update add py3-poetry
        echo "[+] poetry installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi

else
    echo "[+] poetry is already installed"
fi

# Check if pytest is installed by running 'pytest --version'
pytest --version > /dev/null

# Check the exit status of the previous command to determine if pytest is installed
if [[ $? != 0 ]]; then
    # Source the OS release information to determine the distribution
    . /etc/os-release

    # Install pytest based on the detected OS distribution
    if [[ $ID = "debian" || $ID = 'ubuntu' ]]; then
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt install -y python3-poetry python3-pytest python3-dev
        echo "[+] pytest installed on Debian/Ubuntu"

    elif [[ $ID = "rocky" ]]; then
        sudo dnf update -y
        sudo dnf install -y python3-poetry python3-pytest python3-devel
        echo "[+] pytest installed on Rocky"

    elif [[ $ID = "alpine" ]]; then 
        sudo apk --no-cache --update add py3-poetry py3-pytest py3-dev
        echo "[+] pytest installed on Alpine"

    else
        # Handle unsupported OS distributions
        printf "[!] Your OS %s is not compatible with this script. \n[!] This script is meant for Debian, Rocky, or Alpine systems ONLY\n" $ID
        exit 1
    fi

else
    echo "[+] pytest is already installed"
fi
