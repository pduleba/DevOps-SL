# DevOps-SL

## Overview
Purpose of this repository is to learn how to put all together all DevOps pieces:
* custom VPC with SubNets (Public&Private), RT, IGW, NAT-Gateway, EIP, NACL, Security Group
* ELB (Application Load Balancing)
* S3 + PreSigned-URL
* RDS + Multi-AZ
* AutoScaling Group

using 
* `frontend` as S3 website + JS
* `backend` as RESTful API running on Spring Boot application.

## AWS related documentation
 * [Working with AWS Credentials](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/credentials.html)
 * [Environment Variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
 * [Set up AWS Credentials and Region for Development](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)