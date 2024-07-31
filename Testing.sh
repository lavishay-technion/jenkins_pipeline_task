#!/bin/bash
EXCLUDE_PATHS_FILES=("jenkins_data" "docker" ".git" "spellcheck_results.md" ".DS_Store" "spellchech.sh" "spelltest.sh" "." "..")
echo 
echo "" > 1.txt
for i in $(ls -Ra);
do
    if [[ $i == $(printf "%s\n" "${EXCLUDE_PATHS_FILES[@]}" | grep -q "$i") ]]
    then
        continue
    else
        echo $i >> 1.txt
    fi  
done

