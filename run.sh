#!/bin/bash

# Repo to download
GITHUB_OWNER="UnownHash"
GITHUB_REPO="Dragonite-Public"

# Check if an argument is provided to specify the file
if [ $# -eq 0 ]; then
    echo "Usage: $0 [linux-amd64|darwin-arm64|linux-arm64]"
    exit 1
fi

# Get the selected file name from the argument
FILE_NAME="dragonite-$1"

# Fetch the latest tags from the local Git repository
git fetch --tags

# Get the latest Git tag for the GitHub repository
latest_tag=$(git tag --list | sort -V | tail -n 1)

# Define the latest Git tag
RELEASE_TAG="$latest_tag"

# Get the list of releases using the GitHub API
api_url="https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/tags/$latest_tag"
releases_info=$(curl -s "$api_url")

# Extract the download URL for the specific file in the latest release
download_url=$(echo "$releases_info" | jq -r ".assets[] | select(.name == \"$FILE_NAME\").url")

# Define the download file name based on the selected file
download_filename="$FILE_NAME"

# Download the specific release file
curl -L -H "Accept: application/octet-stream" -o "$download_filename"  "$download_url"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download the release file"
    exit 1
fi

echo "Downloaded $download_filename from the latest release with tag $RELEASE_TAG"
