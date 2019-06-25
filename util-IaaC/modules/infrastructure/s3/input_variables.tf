##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "app_bucket_cors_allowed_headers" { type = "list" }
variable "app_bucket_cors_allowed_methods" { type = "list" }
variable "app_bucket_cors_allowed_origins" { type = "list" }

variable "access_log_bucket_id" {}

variable "ssm_parameter_environment_postfix" {}
variable "ssm_parameter_app_bucket_key_postfix" {}
