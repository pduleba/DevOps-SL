##################################################################################
# VARIABLES
##################################################################################

/* *************** STATE FILES CONFIGURATION *************** */
variable "state_bucket" {
  description = "A state file S3 bucket name"
}

variable "state_bucket_vpc_key" {
  description = "A state file S3 bucket VPC key"
}

/* *************** ALB CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

variable "instance_ami" {
  description = "An AWS AMI number to be used for bastion EC2 instance"
}

variable "instance_type" {
  description = "An AWS AMI type to be used for bastion EC2 instance"
}

variable "amazon_service_role_arn" {
  description = "An Amazon EC2 service role for SSM ARN"
}

variable "key_pair_name" {
  description = "An AWS EC2 key pair name"
}

variable "app_bucket_postfix" {
  description = "An application S3 bucket name postfix"
}
