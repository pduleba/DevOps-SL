FROM alpine:latest

LABEL maintainer="Pawel Duleba<pduleba@pgs-soft.com>"

USER root

WORKDIR /

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

# Install JQ
RUN apk add jq

# Install AWS CLI
RUN apk add python3
RUN ln -s python3 /usr/bin/python
RUN pip3 install --upgrade pip
RUN pip install awscli

# Install terraform
RUN apk add terraform