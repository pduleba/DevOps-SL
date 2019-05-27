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

variable "protocol" {
  description = "An AWS ALB protocol"
}

variable "port" {
  description = "An AWS ALB port"
}

variable "target_group_path_s3" {
  description = "An AWS ALB target group health check path for S3 API"
}

variable "target_group_path_rds" {
  description = "An AWS ALB target group health check path for RDS API"
}

variable "listener_default_action_redirect_path" {
  description = "A default redirection path"
}

variable "listener_rule_s3_condition_values" {
  description = "A S3 API listener roule conditions"
  type        = "list"
}

variable "listener_rule_rds_condition_values" {
  description = "A RDS API listener roule conditions"
  type        = "list"
}

variable "access_log_s3_bucket_log_prefix" {
  description = "An AWS S3 bucket key prefix to store access logs"
}

variable "access_log_s3_bucket_name_postfix" {
  description = "An AWS S3 bucket name postfix to grant access to the access log S3 bucket"
}

variable "access_log_s3_bucket_owner_account_id" {
  description = "A AWS S3 bucket owner id"
}

variable "access_log_alb_owner_account_id" {
  description = "An AWS account ID to grant access to the access log S3 bucket"
}

