#!/bin/bash

# Check for operating system
case $( uname -s ) in
Linux)

    case $( uname -i ) in
    x86_64)
        FILE_PREFIX="linux-amd64"
        ;;
    arm64)
        FILE_PREFIX="linux-arm64"
        ;;
    esac

    ;;
Darwin)
    FILE_PREFIX="darwin-arm64"
    ;;
esac

if [ -z "$FILE_PREFIX" ]; then
  if [ $# -eq 0 ]; then
    echo "Usage: $0 [linux-amd64|darwin-arm64|linux-arm64]"
    exit 1
  fi
  FILE_PREFIX="$1"
fi

if ! [ "$(which jq)" ]; then
  echo "jq is not installed (sudo apt-get install jq)"
  exit 1
fi

# Repo to download
GITHUB_OWNER="UnownHash"
GITHUB_REPO="Dragonite-Public"

# Fetch the latest tags from the local Git repository
git fetch --tags

# Get the latest Git tag for the "dragonite-" prefix
latest_dragonite_tag=$(git tag --list 'dragonite-v*' | sort -V | tail -n 1)
# Get the latest Git tag for the "admin-" prefix
latest_admin_tag=$(git tag --list 'admin-v*' | sort -V | tail -n 1)

download_latest_release() {
  local application="$1"
  local FILE_NAME="$application-$FILE_PREFIX"

  # Set the correct variable based on the prefix
  if [ "$application" == "dragonite" ]; then
    local latest_tag_var="$latest_dragonite_tag"
  elif [ "$application" == "admin" ]; then
    local latest_tag_var="$latest_admin_tag"
  else
    echo "Invalid prefix: $prefix"
    exit 1
  fi

  # Get the list of releases using the GitHub API
  local api_url="https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/tags/$latest_tag_var"
  local releases_info=$(curl -sf "$api_url")

  if [ -z "$releases_info" ]; then
    echo "Failed to download $application release information"
    exit 1
  fi

  # Extract the download URL for the specific file in the latest release
  local download_url=$(echo "$releases_info" | jq -r ".assets[] | select(.name == \"$FILE_NAME\").url")

  # Define the download file name based on the selected file
  local download_filename="$FILE_NAME"

  # Download the specific release file
  curl -L -H "Accept: application/octet-stream" -o "$application/$download_filename" "$download_url"

  # Check if the download was successful
  if [ $? -ne 0 ]; then
    echo "Failed to download the release file"
    exit 1
  fi
  echo "Downloaded $download_filename"
}

download_latest_release "dragonite"
download_latest_release "admin"

echo "Latest release with tag $latest_dragonite_tag"
echo "Latest release with tag $latest_admin_tag"
