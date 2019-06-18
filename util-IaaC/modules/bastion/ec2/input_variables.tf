##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "instance_security_group_name_postfix" {}

variable "instance_image_id" {}
variable "instance_type" {}
variable "instance_key_name" {}
variable "instance_user_data_template_path" {}

variable "ssm_policy_arn" {}

variable "app_bucket_postfix" {}
