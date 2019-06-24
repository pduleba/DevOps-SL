#!/usr/bin/env bash

sudo rm -rf /etc/init.d/app-rest
sudo chattr -Rf -i /home/ec2-user/app-rest/*
sudo rm -rf /home/ec2-user/app-rest
