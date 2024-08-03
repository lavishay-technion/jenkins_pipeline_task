#!/bin/bash

################################################################################
##  This Script runs spell check for all text containing files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum - 50%
##  Resources: 
##      https://github.com/hunspell/hunspell

################################################################################



. /etc/os-release ## Loading variables in that file to RAM, to check $ID content

#######################################################
### Checking hunspell installation
#######################################################

hunspell --version 2> /dev/null ## Checking if hunspell is installed
if [[ $? != 0 ]]; ## If hunspell is not installed, install hunspell according to the correct OS
then
    ### Checking if the OS is Debian, Rocky or Alpine and running installations for hunspell accordingly
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update
        sudo apt-get install -y hunspell
        echo "#######################################"
        echo "[+] hunspell installed on Debian"
        echo "#######################################"
    elif [[ $ID = "rocky" ]]
    then
        sudo dnf update -y
        sudo dnf install hunspell -y
        echo "#######################################"
        echo "[+] hunspell installed on Rocky"
        echo "#######################################"
    elif [[ $ID = 'alpine' ]]
    then
        apk add hunspell 
        echo "#######################################"
        echo " "
        echo "[+] hunspell installed on Alpine"
        echo "#######################################"
    else
        echo "#######################################"
        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
fi

#######################################################
## Checking GIT installation
#######################################################

git --version 2> /dev/null  ## Checking if GIT is installed

if [[ $? != 0 ]]; ## If GIT is not installed, install GIT according to the correct OS
then
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update
        sudo apt-get install -y git
        echo "#######################################"
        echo "[+] git installed on Debian"
        echo "#######################################"
    elif [[ $ID = "rocky" ]]
    then
        sudo dnf update -y
        sudo dnf install git -y
        echo "#######################################"
        echo "[+] git installed on Rocky"
        echo "#######################################"
    elif [[ $ID = 'alpine' ]]
    then
        apk add git 
        echo "#######################################"
        echo " "
        echo "[+] git installed on Alpine"
        echo "#######################################"
    else
        echo "#######################################"
        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
else
    echo "[+] GIT is already installed"
fi

#######################################################
### Cloning Repo
#######################################################

### Checking if the GIT repo was already cloned on that worker
if [[ ! -d "/tmp/details_app"  ]]; then  ## If folder not found, clone it
    git clone https://github.com/lavishay-technion/details_app.git /tmp/details_app/
    echo "Project cloned to /tmp/details_app"
else  ## If folder found, update it with pull
    git pull https://github.com/lavishay-technion/details_app.git /tmp/details_app/
    echo "Project updated in /tmp/details_app"
fi
