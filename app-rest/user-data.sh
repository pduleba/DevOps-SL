#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y
# Check installation location via `repoquery -l java-1.8.0-openjdk-devel`
sudo sh -c "echo export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.amzn2.x86_64 >> /etc/environment"
source /etc/environment
sudo mkdir /var/app-rest
sudo wget https://github.com/pduleba/DevOps-SL/releases/download/app-rest-0.0.1/app-rest-0.0.1.jar -O /var/app-rest/app-rest-0.0.1.jar
sudo chmod +x /var/app-rest/app-rest-0.0.1.jar
sudo chown ec2-user:ec2-user /var/app-rest/app-rest-0.0.1.jar
sudo touch /var/log/app-rest.log
sudo chmod +w /var/log/app-rest.log
sudo chown ec2-user:ec2-user /var/log/app-rest.log
sudo ln -s /var/app-rest/app-rest-0.0.1.jar /etc/init.d/app-rest
sudo chkconfig app-rest on
sudo service app-rest start

# Check status 
sudo service app-rest status
# Logs available at /var/log/<appname>.log
