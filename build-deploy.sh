#!/bin/bash

ls

# Install dependencies
npm i -f

# Run npm build command
npm run build

# Archive build artifacts
tar -czvf ${CI_JOB_NAME}_${CI_COMMIT_REF_NAME}.tar.gz build

ls
echo "Hello, $GITLAB_USER_LOGIN!"

