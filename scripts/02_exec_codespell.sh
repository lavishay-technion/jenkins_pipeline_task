#!/bin/bash

# -------------------------------------------------------------
# This Script finds all .sh scripts and runs codespell on them.
# -------------------------------------------------------------

# Check if the directory $OUTPOT_DIR exists; if not, create a reports directory
if [[ ! -d $OUTPUT_DIR ]]; then
    mkdir $OUTPUT_DIR
fi
##Creating files with typos
echo lable > $APP_DIR/file_with_typos.txt
echo devic > $APP_DIR/file_with_typos.txt
echo varning > $APP_DIR/file_with_typos2.txt
echo implemen > $APP_DIR/file_with_typos2.txt
echo nd > $APP_DIR/file_with_typos1.txt
echo suppor > $APP_DIR/file_with_typos1.txt

#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins "${OUTPUT_DIR}"

# Initialize the output file with a header
echo "==================" > "${OUTPUT_DIR}/02_codespell_results.md"
echo "CodeSpell Results" >> "${OUTPUT_DIR}/02_codespell_results.md"
echo "==================" >> "${OUTPUT_DIR}/02_codespell_results.md"

# Loop through all directories specified in PATHS_LOCATION and find .sh files
codespell -c $APP_DIR >> "${OUTPUT_DIR}/02_codespell_results.md"

# for LOCATION in "${APP_DIR[@]}"; do
#     if [[ $LOCATION != '' ]]; then
#         # Find .sh files in the current location and run codespell on them
#         find $LOCATION -name "*.sh" -exec codespell {} + >> "${OUTPUT_DIR}/02_codespell_results.md"
#     else
#         echo "[-] Location was not provided"
#     fi
# done

# Notify the user that the results have been saved
echo "[v] Code Spell Results saved in ${OUTPUT_DIR}/02_codespell_results.md"


