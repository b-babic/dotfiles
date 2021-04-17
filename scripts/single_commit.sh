#!/bin/bash

# Function to display usage
usage() {
  echo "Usage: $0 [-t version]"
  echo "  -t version   Optional version number for tagging (e.g., 1.0.0)"
}

# Ensure we are in a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "This script must be run from within a Git repository."
  exit 1
fi

# Get the repository name
REPO_NAME=$(basename `git rev-parse --show-toplevel`)

# Check if no arguments are provided
if [ $# -eq 0 ]; then
  usage
  echo "Repository: $REPO_NAME"
  read -p "No options provided. Do you want to proceed? (y/n): " CONFIRM
  if [ "$CONFIRM" != "y" ]; then
    echo "Aborting."
    exit 1
  fi
fi

# Parse optional arguments
while getopts ":t:" opt; do
  case ${opt} in
    t )
      VERSION=$OPTARG
      ;;
    \? )
      usage
      exit 1
      ;;
  esac
done

# Prompt for a descriptive commit message
read -p "Enter a descriptive commit message for the repository '$REPO_NAME': " COMMIT_MESSAGE

# Check if the commit message is empty
if [ -z "$COMMIT_MESSAGE" ]; then
  echo "Commit message cannot be empty."
  exit 1
fi

# Squash all commits into a single commit
git reset $(git commit-tree HEAD^{tree} -m "$COMMIT_MESSAGE")
git add .
git commit -m "$COMMIT_MESSAGE"

# Tag the commit if a version number is provided
if [ ! -z "$VERSION" ]; then
  git tag "v$VERSION"
fi

echo "All commits have been squashed into a single commit."
if [ ! -z "$VERSION" ]; then
  echo "Tagged with version v$VERSION."
fi
