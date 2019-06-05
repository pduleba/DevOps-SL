FROM jenkinsci/blueocean:latest

LABEL maintainer="Pawel Duleba<pduleba@pgs-soft.com>"

USER root

WORKDIR /

# Update repos (https://wiki.alpinelinux.org/wiki/Enable_Community_Repository)
RUN sed -i 's/v3.9/edge/g' /etc/apk/repositories

# Refresh
RUN apk update && apk upgrade
