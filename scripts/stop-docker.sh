#!/bin/sh

if [ $(docker ps -aq --filter name=packpeek) ]; then
    echo "Stopping container named 'packpeek'..."
    docker stop packpeek
fi