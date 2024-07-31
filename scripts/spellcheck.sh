#!/bin/bash

################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
################################################################################

### Initial step to clone the Details App project into /tmp folder for the testing
cd /tmp/
git clone https://github.com/lavishay-technion/details_app.git

### Checking if the OS is Debian, Rocky or Alpine and running installations accordingly
. /etc/os-release

if [[ $ID = "debian" ]]
then
    sudo apt-get update
    sudo apt-get install -y aspell
    echo "#######################################"
    echo "[+] aspell installed on Debian"
    echo "#######################################"
elif [[ $ID = "rocky" ]]
then
    sudo dnf update 
    sudo dnf install aspell-br.x86_64 -y
    echo "#######################################"
    echo "[+] aspell installed on Rocky"
    echo "#######################################"
elif [[ $ID = 'alpine' ]]
then
    apk add aspell
    echo "#######################################"
    echo "[+] aspell installed on Alpine"
    echo "#######################################"
else
    echo "#######################################"
    printf "[!] OS %s Is not compatible with this pipeline. \n[!] This is meant for Debian, Rocky or Alpine systems ONLY\n" $ID
    echo "#######################################"
    exit 1
fi

### Doing the actual testing of every python file in the details app project
echo "Running script, can't get it to work at this time"
#!/bin/bash

for i in $(ls -Ra); 
do
    if [[ $i != "." && $i != ".." ]]
    then
        aspell -c
        echo $i >> files.tx
    fi
done



