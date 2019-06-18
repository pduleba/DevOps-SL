##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}

variable "app_bucket_postfix" {}

variable "access_log_bucket_name_postfix" {}
variable "access_log_bucket_log_prefix" {}
variable "access_log_bucket_owner_account_id" {}
variable "access_log_alb_owner_account_id" {}

variable "ssm_parameter_environment_postfix" {}
variable "ssm_parameter_app_bucket_key_postfix" {}
