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

variable "ec2_security_group_name_postfix" {}

variable "target_group_rds_name_postfix" {}
variable "target_group_s3_name_postfix" {}

variable "instance_ami" {}
variable "instance_type" {}
variable "instance_key_pair_name" {}
variable "instance_ssm_service_role_arn" {}

variable "autoscaling_serivce_role_arn" {}
variable "autoscaling_min_size" {}
variable "autoscaling_desired_size" {}
variable "autoscaling_max_size" {}

variable "app_bucket_postfix" {}
