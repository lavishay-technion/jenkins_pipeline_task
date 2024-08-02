#!/bin/bash

################################################################################
##  This Script runs codespell and shell check for all text containing files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
################################################################################



. /etc/os-release ## Loading variables in that file to RAM, to check $ID content

#######################################################
### Checking codespell installation
#######################################################

codespell --version 2> /dev/null ## Checking if codespell is installed
if [[ $? != 0 ]]; ## If codespell and is not installed, install codespell and according to the correct OS
then
    echo "#######################################"
    ### Checking if the OS is Debian, Rocky or Alpine and running installations for hunspell accordingly
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update
        sudo apt-get install snapd
        sudo snap install snapd
        sudo snap install codespell
        echo "[+] codespell installed on Debian"

    elif [[ $ID = "rocky" ]]
    then
        sudo dnf install python3-pip -y
        pip3 install codespell
        echo "[+] codespell installed on Rocky"


    elif [[ $ID = 'alpine' ]]
    then
        apk add py3-pip
        pip install py3-codespell

        echo " "
        echo "[+] codespell installed on Alpine"

    else

        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
    echo "#######################################"
fi


#######################################################
### Checking codespell and shellcheck installation
#######################################################

shellcheck --version 2> /dev/null ## Checking if shellcheck is installed
if [[ $? != 0 ]]; ## If shellcheck and is not installed, install shellcheck and according to the correct OS
then
    echo "#######################################"
    ### Checking if the OS is Debian, Rocky or Alpine and running installations for hunspell accordingly
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update -y
        sudo apt-get install shellcheck -y
        echo "[+] shellcheck installed on Debian"

    elif [[ $ID = "rocky" ]]
    then
        sudo dnf update -y
        sudo dnf install epel-release shellcheck -y
        echo "[+] shellcheck installed on Rocky"


    elif [[ $ID = 'alpine' ]]
    then
        apk update
        apk add shellcheck -y
        echo "[+] codespell installed on Alpine"

    else

        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
    echo "#######################################"
fi

#######################################################
## Checking GIT installation
#######################################################

git --version 2> /dev/null  ## Checking if GIT is installed

if [[ $? != 0 ]]; ## If GIT is not installed, install GIT according to the correct OS
then
    echo "#######################################"
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update
        sudo apt-get install -y git
        echo "[+] git installed on Debian"
    elif [[ $ID = "rocky" ]]
    then
        sudo dnf update -y
        sudo dnf install git -y
        echo "[+] git installed on Rocky"
    elif [[ $ID = 'alpine' ]]
    then
        apk add git 
        echo " "
        echo "[+] git installed on Alpine"
    else
        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
    echo "#######################################"
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
