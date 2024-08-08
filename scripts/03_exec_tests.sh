#!/bin/bash

# --------------------------------------------------------------------------------------------
# This Script sets up a Poetry environment, installs dependencies, and runs pytest on the Details_App project.
# Author: Ori Nahum
# Collaborator: Avishay Layani
# --------------------------------------------------------------------------------------------

HOME_DIR=$(pwd)

# Check if the directory $OUTPOT_DIR exists; if not, create a reports directory
if [[ ! -d $OUTPUT_DIR ]]; then
    mkdir $OUTPUT_DIR
fi

#### Changing ownership of the reports folder, as it's in Volume, it's created with root permissions
sudo chown -R jenkins:jenkins "${OUTPUT_DIR}"

# Initialize the output file with headers
echo "==================" > "${OUTPUT_DIR}/03_pytest_result.md"
echo "Pytest Results" >> "${OUTPUT_DIR}/03_pytest_result.md"
echo "==================" >> "${OUTPUT_DIR}/03_pytest_result.md"
echo "" >> "${OUTPUT_DIR}/03_pytest_result.md"

    # Try to initialize a new poetry project with no interaction
    init_output=$(poetry init --no-interaction 2>&1)

    # Check if the output contains "already exists"
    if echo "$init_output" | grep -q "already exists"; then
        echo "Poetry project already initialized in $APP_DIR"
        poetry shell
    else
        echo "Poetry project initialized in $APP_DIR"
    fi
    
# Generate the poetry.lock file without updating dependencies 
poetry lock # [--no-update]
# Add pytest-html as a dependency for generating HTML test reports
poetry add pytest-html
# Install project dependencies into the Poetry environment
poetry -C $APP_DIR install
# Set an environment variable for the test database
export TEST_DB=True
# Change directory to the application directory
cd $APP_DIR
# Run pytest and generate an HTML report
poetry run pytest --html="${OUTPUT_DIR}/03_pytest_results.html" ## --self-contained-html 
# Run pytest and save the results to the markdown file
poetry run pytest > "${OUTPUT_DIR}/03_pytest_result.md"
# Return to the original directory
cd $HOME_DIR
# Exit the script
exit
