#!/usr/bin/env bash

sudo chmod +x /home/ec2-user/app-rest/app-rest-RELEASE_VERSION.jar
sudo chattr +i /home/ec2-user/app-rest/app-rest-RELEASE_VERSION.jar
sudo ln -sf /home/ec2-user/app-rest/app-rest-RELEASE_VERSION.jar /etc/init.d/app-rest
sudo chkconfig app-rest on
