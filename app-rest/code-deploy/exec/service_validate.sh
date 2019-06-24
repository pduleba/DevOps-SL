#!/usr/bin/env bash

while [[ true ]]
do
    if [[ $(systemctl is-active app-rest) == 'active' ]]
    then
        echo "Checking service status..."
        sleep 3s
    else
        echo "Service is running!"
        exit 0
    fi
done
