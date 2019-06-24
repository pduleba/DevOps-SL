#!/usr/bin/env bash

if [[ $(systemctl is-active app-rest) == 'active' ]]
then
    echo "Stopping service..."
    sudo service app-rest stop
    echo "Stopping service... Complete"
else
    echo "Service already stopped"
fi