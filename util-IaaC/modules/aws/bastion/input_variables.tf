##################################################################################
# VARIABLES
##################################################################################

variable "profile" {
}

variable "region" {
}

variable "bucket" {
}

variable "owner" {
}

variable "resource_name_prefix" {
}

variable "vpc_name_postfix" {
}

variable "public_subnet_name_postfix" {
}

variable "private_subnet_name_postfix" {
}

variable "bastion_security_group_name_postfix" {
}

variable "instance_ami" {
  description = "An AWS AMI number to be used for bastion EC2 instance"
}

variable "instance_type" {
  description = "An AWS AMI type to be used for bastion EC2 instance"
}

variable "instance_ssm_service_role_arn" {
  description = "An Amazon EC2 service role for SSM ARN"
}

variable "instance_key_pair_name" {
  description = "An AWS EC2 key pair name"
}

variable "app_bucket_postfix" {
  description = "An application S3 bucket name postfix"
}
