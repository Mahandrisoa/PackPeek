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

# Generate the export filename
EXPORT_FILE="backup/bak_$CURRENT_DATE"

# Run the strapi export command
yarn strapi export --file "$EXPORT_FILE" --key "$EXPORT_ENCRYPTION_KEY"

# Check if the file was successfully exported
if [ -f "$EXPORT_FILE" ]; then
    # Encrypt the file using the EXPORT_ENCRYPTION_KEY from .env
    openssl enc -aes-256-cbc -salt -in "$EXPORT_FILE" -out "$EXPORT_FILE.enc" -pass pass:$EXPORT_ENCRYPTION_KEY

    # Optionally, delete the original file after encryption
    # rm "$EXPORT_FILE"
else
    echo "Failed to export the data!"
    exit 1
fi

echo "Data exported and encrypted successfully!"
