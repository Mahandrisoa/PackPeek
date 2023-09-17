#!/bin/sh

# Run the Strapi data import script
/scripts/import-strapi-data.sh

# Check if the script ran successfully
if [ $? -eq 0 ]; then
    echo "Data import successful. Starting Strapi..."
else
    echo "Data import failed. Exiting."
    exit 1
fi

# Start Strapi (or your main process)
yarn develop
