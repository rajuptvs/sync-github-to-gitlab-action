#!/bin/sh

# Setup SSH and Git configuration
mkdir -p /root/.ssh
echo "$INPUT_DESTINATION_SSH_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keyscan gitlab.com >> /root/.ssh/known_hosts
git config --global --add safe.directory /github/workspace

# Ensure the "sync" branch exists
git fetch origin $INPUT_DESTINATION_BRANCH_NAME:$INPUT_DESTINATION_BRANCH_NAME || git checkout -b $INPUT_DESTINATION_BRANCH_NAME origin/$INPUT_DESTINATION_BRANCH_NAME || git checkout $INPUT_DESTINATION_BRANCH_NAME

# Add the remote and push
git remote add mirror $INPUT_DESTINATION_REPOSITORY
git push mirror $INPUT_DESTINATION_BRANCH_NAME -f
