#!/usr/bin/env bash

echo "-------- VALIDATE BEFORE ---------"
ps aux | grep -v grep | grep java
echo "-------- VALIDATE BEFORE ---------"

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

echo "-------- VALIDATE AFTER ---------"
ps aux | grep -v grep | grep java
echo "-------- VALIDATE AFTER ---------"
