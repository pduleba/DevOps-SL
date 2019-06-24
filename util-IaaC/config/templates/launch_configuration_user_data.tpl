#!/bin/bash
sudo yum update -y
# Code deploy # https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-linux.html
sudo yum install ruby -y
sudo yum install wget -y
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install -P /home/ec2-user
chmod +x /home/ec2-user/install
sudo /home/ec2-user/install auto
sudo chkconfig codedeploy-agent on
sudo service codedeploy-agent status
# Other
sudo yum install nc -y
sudo yum install jq -y
sudo yum install java-1.8.0-openjdk-devel -y
### Check installation location via `repoquery -l java-1.8.0-openjdk-devel`
sudo sh -c "echo export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.201.b09-0.amzn2.x86_64 >> /etc/environment"
source /etc/environment