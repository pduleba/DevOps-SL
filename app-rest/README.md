# app-rest layer :: Spring (Backend) + Angular (Frontend)

## Build

### build `Local` package
* Make sure that `app-db` Docker container is running [See here for more](/app-db)
* `exec-build-local.bat` - build `app-rest` using maven `local` profile
* run executable application ([See deployment-install for more](https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html))
### build `aws` package
* Make sure that AWS MySQL/AWS Aurora is running (version 5.6/8 compatible suggested)
* `exec-build-aws.bat` - build `app-rest` using maven `aws` profile
* run executable application ([See deployment-install for more](https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html))

## Release

### release package
* `exec-release.bat` - release `app-rest` using maven `aws` profile which includes
  * version update
  * create tag with sources on GitHub
  * executable `is not` released
### create package
* `exec-package.bat EXECUTABLE_NAME PACKAGE_NAME` - creates CodeDeploy archive using released executables

## Deploy

### S3 copy
* `exec-s3-copy.sh RELEASE_PACKAGE S3_LOCATION` - copy package to S3 bucket via AWS CLI
### code deploy
* `exec-code-deploy.sh APPLICATION GROUP CONFIG BUCKET KEY BUNDLE_TYPE` - creates CodeDeploy deployment via AWS CLI

## Utils

### Prerequisites 
* `ssh-agent` - start `ssh-agent`
* `ssh-add -k key.pem` - add your PEM key
* `ssh-add -L` - list added keys

### SSH Utils
* `exec-ec2-login.sh PUBLIC_IP` - connects to EC2 instance in public subnet
* `exec-ec2-login-via-bastion.sh PUBLIC_IP PRIVATE_IP` - connects to EC2 instance in private subnet via public subnet bastion

### SCP utils
* `exec-ec2-scp.sh FILE PUBLIC_IP` - copies file to EC2 instance in public subnet
* `exec-ec2-scp-via-bastion.sh FILE PUBLIC_IP PRIVATE_IP` - copies file to EC2 instance in private subnet via public subnet bastion

## API overview

### usage of `app-rest`
* RESTful API
  * Import [DevOps.postman_collection.json](/util-postman/DevOps.postman_collection.json) Postman collection, where
    * `RDSController` contains API for RDS/MySQL
      * http `ping` returns server status for health check purposes
      * http `findAll` all entries in DB
      * http `findById` entry by id in DB
      * http `save` create/update by id from DB
      * http `delete` entry by id from DB
    * `S3Controller` contains API for AWS S3
      * http `ping` returns server status for health check purposes
      * http `findAll` all objects in S3
      * http `save` create/update object by key in S3
      * http `delete` object by key from S3
      * http `signedUrl` signed url generation for S3 http action
* Frontend
  * Enter [MySQL/RDS Frontend](http://localhost:8080/app-rest/rds/index)
  * Enter [S3 Frontend](http://localhost:8080/app-rest/s3/index)