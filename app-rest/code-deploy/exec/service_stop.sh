#!/usr/bin/env bash

echo "-------- PREVIOUS EXIT CODE ---------"
echo "previous exit code" $?
echo "-------- PREVIOUS EXIT CODE ---------"

echo "-------- STOP BEFORE ---------"
ps aux | grep -v grep | grep java
echo "-------- STOP BEFORE ---------"

if [[ $(systemctl is-active app-rest) == 'active' ]]
then
    echo "Stopping service..."
    sudo systemctl stop app-rest
    echo "Stopping service... Complete"
else
    echo "Service already stopped"
fi

echo "-------- STOP AFTER ---------"
ps aux | grep -v grep | grep java
echo "-------- STOP AFTER ---------"
