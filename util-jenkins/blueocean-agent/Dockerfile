FROM alpine:latest

LABEL maintainer="Pawel Duleba<pduleba@pgs-soft.com>"

USER root

WORKDIR /

# UTF-8 encoding
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# Update repos (https://wiki.alpinelinux.org/wiki/Enable_Community_Repository)
RUN sed -i 's/v3.9/edge/g' /etc/apk/repositories

# Refresh
RUN apk update && apk upgrade

# Install bash
RUN apk add bash
RUN apk add bash-doc
RUN apk add bash-completion
RUN sed -i 's/^root.*\/bin\/ash/root:x:0:0:root:\/root:\/bin\/bash/1' /etc/passwd
ENV PS1 '\u@\h:\W \$ '

# Install OpenJDK
RUN apk add openjdk8
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

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
