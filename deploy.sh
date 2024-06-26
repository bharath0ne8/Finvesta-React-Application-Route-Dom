#!/bin/bash

destination_path="/var/www/$DeploymentType/finvestauat/"

# Check if the build directory exists in the new-folder
if [ -d "$destination_path/build" ]; then
    # If the build directory exists, remove it
    echo "Removing existing build directory..."
    rm -rf "$destination_path/build"
fi


# Check if tar.gz file exists
if [ -f "./build-job_DevRelease.tar.gz" ]; then
    # Extract build artifacts
    tar -xzvf "./build-job_DevRelease.tar.gz" --directory "$destination_path"
    echo "Build artifacts extracted successfully."
else
    echo "Error: build-job_DevRelease.tar.gz file not found."
    exit 1
fi


sudo systemctl reload nginx

if [ $? -eq 0 ]; then
    echo "Deployment completed successfully."
else
    echo "Error: Deployment failed. Nginx reload unsuccessful."
    exit 1
fi

#if [ $? -eq 0 ]; then
    #echo "Deployment completed successfully."
#else
 #   echo "Deployment failed."
#fi


