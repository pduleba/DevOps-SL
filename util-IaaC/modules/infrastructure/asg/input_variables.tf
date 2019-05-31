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

variable "launch_configuration_image_id" {}
variable "launch_configuration_instance_type" {}
variable "launch_configuration_key_name" {}
variable "launch_configuration_user_data_script_path" {}

variable "ssm_policy_arn" {}

variable "autoscaling_serivce_role_arn" {}
variable "autoscaling_min_size" {}
variable "autoscaling_desired_size" {}
variable "autoscaling_max_size" {}

variable "ssm_parameter_alb_host_key_postfix" {}

variable "app_bucket_postfix" {}
