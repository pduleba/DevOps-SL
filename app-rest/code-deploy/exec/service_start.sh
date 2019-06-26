#!/usr/bin/env bash

echo "-------- PREVIOUS EXIT CODE ---------"
echo "previous exit code" $?
echo "-------- PREVIOUS EXIT CODE ---------"

echo "-------- START BEFORE ---------"
ps aux | grep -v grep | grep java
echo "-------- START BEFORE ---------"

if [[ $(systemctl is-active app-rest) == 'active' ]]
then
    echo "Service already started"
else
    echo "Starting service..."
    sudo systemctl start app-rest
    echo "Starting service... Complete"
fi

echo "-------- START AFTER ---------"
ps aux | grep -v grep | grep java
echo "-------- START AFTER ---------"
