FROM pduleba/blueocean-edge:latest

LABEL maintainer="Pawel Duleba<pduleba@pgs-soft.com>"

USER root

WORKDIR /

# Update repos (https://wiki.alpinelinux.org/wiki/Enable_Community_Repository)
RUN sed -i 's/v3.9/edge/g' /etc/apk/repositories

# Refresh
RUN apk update && apk upgrade

# Update bash
ENV PS1 '\u@\h:\W \$ '

# Install git
RUN apk add git

# Install Maven
RUN apk add maven
ENV MAVEN_HOME /usr/share/java/maven-3

# Install JQ
RUN apk add jq

# Install AWS CLI
RUN apk add python3
RUN ln -s python3 /usr/bin/python
RUN pip3 install --upgrade pip
RUN pip install awscli

# Install docker
RUN apk add docker

# Install ansible
RUN apk add ansible

# Install terraform
RUN wget -O ~/terraform_0.12.1_linux_amd64.zip https://releases.hashicorp.com/terraform/0.12.1/terraform_0.12.1_linux_amd64.zip
RUN unzip ~/terraform_0.12.1_linux_amd64.zip -d ~/
RUN mv ~/terraform /usr/bin/ && rm -rf terraform_0.12.1_linux_amd64.zip

# For HTTP
EXPOSE 8181:8080/tcp
# For build executors agents
EXPOSE 50000:50000/tcp
