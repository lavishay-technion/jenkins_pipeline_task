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
echo "##############" > /home/reports/pytest.md


### Running pytest recursively on all Python scripts that end with .py in the application's directory and adding it to the report
pytest $APP_DIR --log-file=/home/reports/pytest.md


echo "##############" >> /home/reports/pytest.md