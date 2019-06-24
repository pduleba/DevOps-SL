#!/usr/bin/env bash

if [[ $(systemctl is-active app-rest) == 'active' ]]
then
    echo "Service already started"
else
    echo "Starting service..."
    sudo service app-rest start
    echo "Starting service... Complete"
fi