#!/bin/bash

#################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
##  Packages needed: hunspell 
#################################################################################

##################################################################################################
#   This script depends on the installation script with cloning the GIT
#   It runs hunspell on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at Jenkins_pipeline_task/docker/reports as spell_check_report
##################################################################################################


#!/bin/bash

#################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
##  Packages needed: hunspell 
#################################################################################

##################################################################################################
#   This script depends on the installation script with cloning the GIT
#   It runs hunspell on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at Jenkins_pipeline_task/docker/reports as spell_check_report
##################################################################################################



#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins /home/reports


### Stating first line of the file, cleaning it from past scripts' data.
echo "##############" > /home/reports/codespell.md



    codespell $i *.sh,*.py >> /home/reports/codespell.md
    echo "##############" >> /home/reports/codespell.md
