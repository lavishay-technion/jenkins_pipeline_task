#!/usr/bin/env bash


# Navigate to the project directory
cd "$APP_DIR" || { echo "Directory $APP_DIR does not exist."; exit 1; }

# Build the Docker image
cd $APP_DIR
docker build . -t details_app

sudo docker images

# # Confirm successful push
# if [ $? -eq 0 ]; then
#   echo "Docker image successfully pushed to Docker Hub."
# else
#   echo "Failed to push Docker image to Docker Hub."
#   exit 1
# fi
