#!/bin/bash

################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
################################################################################

#################################################
#   This script depends on the installation script with cloning the GIT
#   It runs hunspell on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at ./docker/reports as spell_check_report
#################################################

### Doing the actual testing of every file in the details app project
echo '' >> /home/reports/spell_check_report
for i in $(find  /tmp/details_app/);
do
    cat $i &> /dev/null
    if [[ $? == '0' ]]; then
        printf "\n\n####################\nFile Name with path: %s \n####################\n" $i >> /home/reports/spell_check_report
        hunspell -u -d en_US $i >> /home/reports/spell_check_report
        printf "\n\n\n\n"
    else
        echo "Skipping in the second step" $i
        echo "############"
    fi

done