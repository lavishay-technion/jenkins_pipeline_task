#!/bin/bash
EXCLUDE_PATHS_FILES=("jenkins_data" "docker" ".git" "spellcheck_results.md" ".DS_Store" "spellchech.sh" "spelltest.sh" "." "..")
#echo ${EXCLUDE_PATHS_FILES[@]} > exclusion.txt
echo "" > 1.txt
for i in $(ls -Ra);
do
    # if grep "$i" "${EXCLUDE_PATHS_FILES[@]}"; then
    # # if [[ $i =~ ^($(echo $EXCLUDE_PATHS_FILES))$ ]]; then
    #     echo SKIP
    # else
    #     echo $i >> 1.txt
    # fi  
    echo "Showing file name:"
    echo $i
    echo "Displaying the file if possible:"
    cat $i 2> /dev/null
    if [[ $? == '0' ]]; then
        printf "\n\n####################\nFile %s \n####################\n" $i
        hunspell -u -d en_US $i
    fi
    printf "\n\n\n\n"
done



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