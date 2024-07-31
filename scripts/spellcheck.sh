#!/bin/bash

################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
################################################################################

### Initial step to clone the Details App project into /tmp folder for the testing
cd /tmp/
git clone https://github.com/lavishay-technion/details_app.git
cd details_app
### Checking if the OS is Debian, Rocky or Alpine and running installations accordingly
. /etc/os-release

if [[ $ID = "debian" ]]
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
    echo "[+] hunspell installed on Alpine"
    echo "#######################################"
else
    echo "#######################################"
    printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
    echo "#######################################"
    exit 1
fi

### Doing the actual testing of every file in the details app project
echo '' >> /var/reports/spell_check_report
for i in $(ls -Ra /tmp/details_app/);
do
    cat $i &> /dev/null
    if [[ $? == '0' ]]; then
        printf "\n\n####################\nFile %s \n####################\n" $i >> /var/reports/spell_check_report
        hunspell -u -d en_US $i >> /var/reports/spell_check_report
    fi
    printf "\n\n\n\n"
done



