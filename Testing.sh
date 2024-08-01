#!/bin/bash
EXCLUDE_PATHS_FILES=("*jenkins_data*" "*docker*" "*.git*" "*spellcheck_results.md*" "*.DS_Store*" "*spellchech.sh*" "*spelltest.sh*" "." "..")
echo ${EXCLUDE_PATHS_FILES[@]} > temp.txt
### Doing the actual testing of every file in the details app project
echo '' > ./spell_check_report
for i in $(find $PWD);
do  
    exists() "$i"
    if ( exists "$i" ); then
        echo "Skipping" $i
        continue
    else
        cat $i &> /dev/null
        if [[ $? == '0' ]]; then
            printf "\n\n####################\nFile %s \n####################\n" $i >> ./spell_check_report
            hunspell -u -d en_US $i >> ./spell_check_report
            printf "\n\n\n\n"
        else
            echo "Skipping in the second step" $i
            echo "############"
        fi
    fi
done


function exists {
    file=$1
    if [[ jenkins_data =~ $file || \
        docker =~ $file || \
        .git =~ $file || \
        spellcheck_results.md =~ $file || \
        .DS_Store =~ $file || \
        spellcheck.sh =~ $file || \
        spelltest.sh =~ $file || \]]; then
        return 1
    else
        return 0
}

# # Define the list of paths to exclude(aspell list <cat $i) >> testing.txt
# EXCLUDE_PATHS_FILES=("jenkins_data" "docker" ".git" "spellcheck_results.md" ".DS_Store" "spellcheck.sh" "spelltest.sh" "." "..")

# # Create or clear the output file
# echo "" > 1.txt

# # List all files and directories recursively
# for i in $(ls -Ra); do
#     # Flag to indicate if the current item should be excluded
#     EXCLUDE=false
    
#     # Check if the current item matches any of the exclusion patterns
#     for pattern in "${EXCLUDE_PATHS_FILES[@]}"; do
#         if [[ $i =~ "$pattern" ]]; then
#             EXCLUDE=true
#             break
#         fi
#     done

#     # If the item is not excluded, append it to the output file
#     if [ "$EXCLUDE" = false ]; then
#         # (aspell list <cat $i) >> testing.txt
#         hunspell -u -d en_US $i >> testing.txt
#     else
#         echo "SKIP: $i"
#     fi  
# done