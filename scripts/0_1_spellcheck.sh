#!/bin/bash

################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
################################################################################


### Checking if the OS is Debian, Rocky or Alpine and running installations for hunspell accordingly
. /etc/os-release

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

# git --version 2> /dev/null

# if [[ $? == 0 ]]; 
# then
git clone https://github.com/lavishay-technion/details_app.git /tmp/details_app/
#     echo "Project cloned to /tmp/details_app"
# else
#     echo "[!] GIT is not installed - Exiting"
# fi


