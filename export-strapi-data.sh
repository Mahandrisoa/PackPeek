#!/bin/sh

# Get the current date in YYYYMMDD format
CURRENT_DATE=$(date +"%Y%m%d")

# Run the strapi export command with the dynamic filename
yarn strapi export --file ""
#!/bin/sh

# Get the current date in YYYYMMDD format
CURRENT_DATE=$(date +"%Y%m%d")

# Run the strapi export command with the dynamic filename
yarn strapi export --file "backup/bak_$CURRENT_DATE"

