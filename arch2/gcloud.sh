#!/bin/bash

set -e

ARCHIVE_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
ARCHIVE_NAME="google-cloud-cli-linux-x86_64.tar.gz"
TEMP_DIR=$(mktemp -d)

echo "Downloading Google Cloud SDK..."
curl -L -o "${TEMP_DIR}/${ARCHIVE_NAME}" "${ARCHIVE_URL}"

echo "Extracting archive..."
tar -xzf "${TEMP_DIR}/${ARCHIVE_NAME}" -C "${TEMP_DIR}"

echo "Installing gcloud to /usr/local/bin..."
sudo cp -r "${TEMP_DIR}/google-cloud-sdk" /opt/
sudo ln -s /opt/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
sudo chmod +x /usr/local/bin/gcloud

rm -rf "${TEMP_DIR}"

echo "gcloud installed successfully!"
