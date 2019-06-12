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

variable "alb_security_group_name_postfix" {}

variable "protocol" {}
variable "port" {}

variable "target_group_deregistration_delay" {}
variable "target_group_slow_start" {}
variable "target_group_rds_name_postfix" {}
variable "target_group_rds_path" {}
variable "target_group_s3_name_postfix" {}
variable "target_group_s3_path" {}

variable "listener_default_action_redirect_path" {}
variable "listener_rule_rds_condition_values" {type = "list"}
variable "listener_rule_s3_condition_values" {type = "list"}

variable "access_log_bucket_name_postfix" {}
variable "access_log_bucket_log_prefix" {}

variable "ssm_parameter_http_host_key_postfix" {}
