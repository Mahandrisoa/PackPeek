#!/bin/sh

# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found!"
    exit 1
fi

# Check if the EXPORT_ENCRYPTION_KEY is set
if [ -z "$EXPORT_ENCRYPTION_KEY" ]; then
    echo "EXPORT_ENCRYPTION_KEY not set in .env file!"
    exit 1
fi

# Get the current date in YYYYMMDD format
CURRENT_DATE=$(date +"%Y%m%d")
ENCRYPTED_FILE="backup/bak_$CURRENT_DATE.tar.gz.enc"
echo "$ENCRYPTED_FILE"

# Check if the encrypted file for today exists
if [ ! -f "$ENCRYPTED_FILE" ]; then
    # If not, get the latest encrypted file with the pattern my-strapi-export-*.enc
    ENCRYPTED_FILE=$(ls backup/my-strapi-export-*.enc | sort -r | head -n 1)
fi

# Check if a file was found and is not empty
if [ -z "$ENCRYPTED_FILE" ]; then
    echo "No suitable encrypted file found for import."
    exit 1
fi

# Run the strapi import command with the decrypted file
yarn strapi import --file "$ENCRYPTED_FILE" --key "$EXPORT_ENCRYPTION_KEY" --force
