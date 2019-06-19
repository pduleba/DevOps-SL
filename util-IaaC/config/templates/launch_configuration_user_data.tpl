#!/bin/bash
sudo yum update -y
sudo yum install nc -y
sudo yum install jq -y
sudo yum install java-1.8.0-openjdk-devel -y
### Check installation location via `repoquery -l java-1.8.0-openjdk-devel`
sudo sh -c "echo export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.amzn2.x86_64 >> /etc/environment"
source /etc/environment