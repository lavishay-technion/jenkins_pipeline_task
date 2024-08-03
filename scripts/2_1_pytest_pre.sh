#!/bin/bash

################################################################################
##  This Script runs pytest and shell check for all text containing files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum - 50%
##  Resources: 
##      
##      
################################################################################



. /etc/os-release ## Loading variables in that file to RAM, to check $ID content

#######################################################
### Checking pytest installation
#######################################################

pytest --version 2> /dev/null ## Checking if pytest is installed
if [[ $? != 0 ]]; ## If pytest and is not installed, install pytest and according to the correct OS
then
    echo "#######################################"
    ## Checking if the OS is Debian, Rocky or Alpine and running installations for hunspell accordingly.
    if [[ $ID = "debian" || $ID = "ubuntu" ]]
    then
        sudo apt-get update -y
        sudo apt-get install python3-pip -y
        pip3 install pytest
        echo "[+] pytest installed on Debian"

    elif [[ $ID = "rocky" ]]
    then
        sudo dnf install python3-pip -y
        pip install pytest
        echo "[+] pytest installed on Rocky"


    elif [[ $ID = 'alpine' ]]
    then
        apk add py3-pip
        pip install pytest
        echo "[+] pytest installed on Alpine"

    else

        printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
        echo "#######################################"
        exit 1
    fi
    echo "#######################################"
fi