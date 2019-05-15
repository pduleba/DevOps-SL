#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y
### Check installation location via `repoquery -l java-1.8.0-openjdk-devel`
sudo sh -c "echo export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.amzn2.x86_64 >> /etc/environment"
source /etc/environment
sudo mkdir /var/app-rest
sudo wget https://github.com/pduleba/DevOps-SL/releases/download/app-rest-0.0.1/app-rest-0.0.1.jar -O /var/app-rest/app-rest-0.0.1.jar

### Secure application (https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html#deployment-initd-service-securing)
sudo chown ec2-user:ec2-user /var/app-rest/app-rest-0.0.1.jar
sudo chmod 500 /var/app-rest/app-rest-0.0.1.jar
sudo chattr +i /var/app-rest/app-rest-0.0.1.jar

sudo ln -s /var/app-rest/app-rest-0.0.1.jar /etc/init.d/app-rest
sudo chkconfig app-rest on

sudo service app-rest start

### Check status
# sudo service app-rest status
### Check logs
# cat /var/log/<appname>.log
