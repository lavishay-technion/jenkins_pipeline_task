#!/bin/bash

#################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum - 50%
##  Packages needed: codespell, shellcheck, python3-pip(For Rocky/Alpine), apt-utils(For Debian)
#################################################################################

##################################################################################################
#   This script depends on the installation script with cloning the GIT
#   It runs codespell and shellcheck on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at Jenkins_pipeline_task/docker/reports as codespell.md & shellcheck.md
#   Resources: https://www.howtogeek.com/devops/using-shellcheck-to-find-and-fix-scripting-bugs/#running-shellcheck
#              https://linuxconfig.org/how-to-improve-and-debug-your-shell-scripts-with-shellcheck
##################################################################################################



#### Changing ownership of the reports folder, as it's in Volume in docker compose, it's created with root permissions
sudo chown -R jenkins:jenkins /home/reports


### Stating first line of the report files, cleaning it from past scripts' data.
echo "##############" > /home/reports/codespell.md
echo "##############" > /home/reports/shellcheck.md
### Running codespell recursively on all files that end with what is entered in SCRIPTS_EXT in the application's directory
codespell $APP_DIR $SCRIPTS_EXT >> /home/reports/codespell.md

for i in $(find $APP_DIR)  ## Running on every file in the app's dir
do
    if [[ $i =~ ".sh" ]]; then ## Checking if it's a bash script
        shellcheck $i >> /home/reports/shellcheck.md ## If yes, running shellcheck on it, and sending it to a report
    fi
done

echo "##############" >> /home/reports/codespell.md
echo "##############" >> /home/reports/shellcheck.md