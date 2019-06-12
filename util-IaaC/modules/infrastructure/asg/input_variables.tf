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

variable "target_group_rds_arn" {}
variable "target_group_s3_arn" {}

variable "launch_configuration_image_id" {}
variable "launch_configuration_instance_type" {}
variable "launch_configuration_key_name" {}
variable "launch_configuration_user_data_script_path" {}

variable "autoscaling_serivce_role_arn" {}
variable "autoscaling_min_size" {}
variable "autoscaling_desired_size" {}
variable "autoscaling_max_size" {}

variable "ssm_policy_arn" {}

variable "app_bucket_postfix" {}
