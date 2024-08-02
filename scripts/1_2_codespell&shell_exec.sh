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



### Prepared a list of files that spam the report with non relevant files to be excluded
EXCLUDE_PATHS_FILES=(".git" ".DS_Store" ".jpi" ".key" ".enc" ".lock" ".jpg" ".mp4" ".ico" ".css")


#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins /home/reports


### Stating first line of the file, cleaning it from past scripts' data.
echo "##############" > /home/reports/spell_check_report
codespell $APP_DIR *.py,*.sh >> /home/reports/codespell.md

## Starting a loop on every item(Files, Folders, etc.) to check if it's a text file to perform hunspell on
# for i in $(find /tmp/details_app);
# do
#     codespell 
#     condition=False ## Setting a variable to be changed to True if found to contain one of the strings in EXCLUDE_PATHS_FILES
#     for u in ${EXCLUDE_PATHS_FILES[@]}
#     do
#         if [[ $i =~ $u ]];then   ### If one of the strings in EXCLUDE_PATHS_FILES exists in the path, changes condition to True, to be skipped 
#             condition=True
#         fi
#     done
#     cat $i &> /dev/null ## Checking if the file can be printed to the screen(Contains text)
#     ## If file is a text file, and not found in the exclusion list, will go through spellcheck
    
#     ## The output of hunspell command, along with other strings to sort out the report, will be saved at a volume in 
#     ## "/home/reports/spell_check_report" in the docker, and JENKINS_PIPELINE_TASK/docker/reports/spell_check_report on the VM
#     if [[ $? == '0' && $condition == 'False' ]]; then  
#         echo "Checking $i"
#         printf "\n\n####################\nFile Name with path: %s \n####################\n" $i >> "/home/reports/spell_check_report"
#         hunspell -u -d en_US $i >> "/home/reports/spell_check_report"
#         printf "\n\n\n\n"
#     else
#         echo "Skipping file $i"  ## Printing skipped files that cannot be printed, or found in the exclusion list.
#     fi
# done




AX