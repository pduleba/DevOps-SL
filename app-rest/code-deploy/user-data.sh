#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk-devel -y
### Check installation location via `repoquery -l java-1.8.0-openjdk-devel`
sudo sh -c "echo export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.amzn2.x86_64 >> /etc/environment"
source /etc/environment
sudo mkdir /home/ec2-user/app-rest
sudo wget https://github.com/pduleba/DevOps-SL/releases/download/app-rest-0.0.8/app-rest-0.0.8.jar -O /home/ec2-user/app-rest/app-rest-0.0.8.jar

### Secure application (https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html#deployment-initd-service-securing)
sudo chown ec2-user:ec2-user /home/ec2-user/app-rest/app-rest-0.0.8.jar
sudo chmod 500 /home/ec2-user/app-rest/app-rest-0.0.8.jar

sudo chmod +x /home/ec2-user/app-rest/app-rest-0.0.8.jar
sudo chattr +i /home/ec2-user/app-rest/app-rest-0.0.8.jar
sudo ln -s /home/ec2-user/app-rest/app-rest-0.0.8.jar /etc/init.d/app-rest
sudo chkconfig app-rest on

sudo service app-rest start

### Check status
# sudo service app-rest status
### Check logs
### ### - Spring Boot
# cat /var/log/app-rest.log
### ### - Code Deploy - https://docs.aws.amazon.com/codedeploy/latest/userguide/deployments-view-logs.html
# cat /opt/codedeploy-agent/deployment-root/deployment-logs/codedeploy-agent-deployments.log