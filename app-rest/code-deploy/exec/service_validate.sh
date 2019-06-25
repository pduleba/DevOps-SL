#!/usr/bin/env bash

while [[ true ]]
do
    status=$(systemctl is-active app-rest)
    if [[ $status == 'active' ]]
    then
        echo "Service is running!"
        exit 0
    else
        echo "Waiting for service under $status status ..."
        sleep 3s
    fi
done
