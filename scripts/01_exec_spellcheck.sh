#!/bin/bash

#################################################################################
##  This Script runs spell check for all Python files in the details-app project
##  Packages needed: hunspell 
##  Resources:
##      https://github.com/hunspell/hunspell
##      https://stackoverflow.com/questions/17241531/examples-tutorials-of-hunspell
#################################################################################

##################################################################################################
#   This script depends on the installation script with cloning the GIT
#   It runs hunspell on every file under on the environment variable that comes from the Jenkins file
#   A report will be saved in /home/reports and it's volumed to the VM at Jenkins_pipeline_task/docker/reports as spell_check_report
##################################################################################################

# Check if the directory $OUTPOT_DIR exists; if not, create a reports directory
echo $OUTPUT_DIR
if [[ ! -d $OUTPUT_DIR ]]; then
    mkdir $OUTPUT_DIR
fi

hostname

#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins "${OUTPUT_DIR}"


### Stating first line of the file, cleaning it from past scripts' data.
echo "##############" > "${OUTPUT_DIR}/01_spellcheck_results.md"

## Starting a loop on every item(Files, Folders, etc.) to check if it's a text file to perform hunspell on
for i in $(find $APP_DIR);
do
    condition=False ## Setting a variable to be changed to True if found to contain one of the strings in EXCLUDE_PATHS_FILES
    for u in ${EXCLUDE_PATHS_FILES[@]}
    do
        if [[ $i =~ $u ]];then   ### If one of the strings in EXCLUDE_PATHS_FILES exists in the path, changes condition to True, to be skipped 
            condition=True
        fi
    done
    cat $i &> /dev/null ## Checking if the file can be printed to the screen(Contains text)
    ## If file is a text file, and not found in the exclusion list, will go through spellcheck
    
    ## The output of hunspell command, along with other strings to sort out the report, will be saved at a volume in 
    ## ""${OUTPUT_DIR}/01_spellcheck_results.md"" in the docker
    if [[ $? == '0' && $condition == 'False' ]]; then  
        printf "\n\n####################\nFile Name with path: %s \n####################\n" $i >> "${OUTPUT_DIR}/01_spellcheck_results.md"
        hunspell -u -d en_US $i >> "${OUTPUT_DIR}/01_spellcheck_results.md"
    fi
done

# Notify the user that spell check results have been saved to the output file
echo "[v] Spell Check Results saved in ${OUTPUT_DIR}/01_spellcheck_results.md"