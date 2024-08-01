#!/bin/bash

################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Author: Avishay Layani
##  Collaborator: Ori Nahum
##  Packages needed for 
################################################################################

#################################################
#   This script depends on the installation script with cloning the GIT
#   It runs hunspell on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at ./docker/reports as spell_check_report
#################################################

### Initial step to clone the Details App project into /tmp folder for the testing. 


### Checking if GIT is installed by running the GIT command we need, and checking if this exists or not




### Checking if the project exists,if yes it pulls 

### Doing the actual testing of every file in the details app project
report_file= "/home/reports/spell_check_report.md"
echo '' >> $report_file
gitdir= $1
for i in $(find  $gitdir);
do
    cat $i &> /dev/null
    exists "$i"
    if [[ $? == '0' ]]; then
        printf "\n\n####################\nFile Name with path: %s \n####################\n" $i >> $report_file
        hunspell -u -d en_US $i >> $report_file
        printf "\n\n\n\n"
    else
        echo "Skipping item: " $i
        echo "############"
    fi

done

EXCLUDE_PATHS_FILES=("jenkins_data" "docker" ".git" "spellcheck_results.md" ".DS_Store" "spellchech.sh" "spelltest.sh" "." "..")
function exists {
    file=$1
    for i in ${EXCLUDE_PATHS_FILES[@]}
    do
        if [[ $file =~ $i ]];then       
            return 1
        else
            return 0
        fi
    done
}


