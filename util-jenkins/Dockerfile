FROM pduleba/blueocean-edge:latest

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

# For HTTP
EXPOSE 8181:8080/tcp
# For build executors agents
EXPOSE 50000:50000/tcp
