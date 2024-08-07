#!/bin/bash

# -------------------------------------------------------------
# This Script finds all .sh scripts and runs ShellCheck on them.
# Author: Ori Nahum
# Collaborator: Avishay Layani
# -------------------------------------------------------------

# Check if the directory $OUTPOT_DIR exists; if not, create a reports directory
if [[ ! -d $OUTPUT_DIR ]]; then
    mkdir $OUTPUT_DIR
fi

#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins "${OUTPUT_DIR}"

# Initialize the output file with a header
echo "==================" > "${OUTPUT_DIR}/02_shellcheck_results.md"
echo "ShellCheck Results" >> "${OUTPUT_DIR}/02_shellcheck_results.md"
echo "==================" >> "${OUTPUT_DIR}/02_shellcheck_results.md"

# Loop through all bash scripts(Looking for files containing with .sh) in the application's directory(mentioned in APP_DIR var)

for i in $(find $APP_DIR); do
    if [[ $i =~ ".sh" ]]; then
        shellcheck $i >> "${OUTPUT_DIR}/02_shellcheck_results.md"
    fi
done


# Notify the user that the results have been saved
echo "[v] Shell Check Results saved in ${OUTPUT_DIR}/02_shellcheck_results.md"
