#!/bin/bash
EXCLUDE_PATHS_FILES=("jenkins_data" "docker" ".git" "spellcheck_results.md" ".DS_Store" "spellchech.sh" "spelltest.sh" "." "..")
echo ${EXCLUDE_PATHS_FILES[@]} > temp.txt
if grep "$i" temp.txt; then
# if [[ $i =~ ^($(echo $EXCLUDE_PATHS_FILES))$ ]]; then
    echo "####################"
    echo SKIP
else
    echo $i
fi  
rm temp.txt