#!/usr/bin/env bash

while [[ true ]]
do
    if [[ $(systemctl is-active app-rest) == 'active' ]]
    then
        echo "Service is running!"
        exit 0
    else
        echo "Waiting for service..."
        sleep 3s
    fi
done
