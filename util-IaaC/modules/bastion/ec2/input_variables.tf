##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "bastion_security_group_name_postfix" {}

variable "instance_ami" {}
variable "instance_type" {}

variable "instance_ssm_service_role_arn" {}
variable "instance_key_pair_name" {}

variable "app_bucket_postfix" {}
