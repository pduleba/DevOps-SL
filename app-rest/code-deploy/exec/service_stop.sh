#!/usr/bin/env bash

if [[ $(systemctl is-active app-rest) == 'active' ]]
then
    echo "Stopping service..."
    sudo systemctl stop app-rest
    echo "Stopping service... Complete"
else
    echo "Service already stopped"
fi