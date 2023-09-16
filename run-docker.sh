#!/bin/sh

# Check if a container named "packpeek" already exists
if [ $(docker ps -aq --filter name=packpeek) ]; then
    echo "Container named 'packpeek' already exists. Stopping and removing..."
    docker stop packpeek
    docker rm packpeek
fi

# Run the Docker container
docker run -d -p 1337:1337 --name packpeek packpeek.back:latest
