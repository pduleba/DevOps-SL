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

variable "alb_security_group_name_postfix" {
}

variable "protocol" {
  description = "An AWS ALB protocol"
}

variable "port" {
  description = "An AWS ALB port"
}

variable "target_group_deregistration_delay" {

}

variable "target_group_slow_start" {

}

variable "target_group_rds_name_postfix" {

}

variable "target_group_rds_path" {
  description = "An AWS ALB target group health check path for RDS API"
}

variable "target_group_s3_name_postfix" {

}

variable "target_group_s3_path" {
  description = "An AWS ALB target group health check path for S3 API"
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

variable "access_log_bucket_name_postfix" {
  description = "An AWS S3 bucket name postfix to grant access to the access log S3 bucket"
}

variable "access_log_bucket_log_prefix" {
  description = "An AWS S3 bucket key prefix to store access logs"
}

variable "access_log_bucket_owner_account_id" {
  description = "A AWS S3 bucket owner id"
}

variable "access_log_alb_owner_account_id" {
  description = "An AWS account ID to grant access to the access log S3 bucket"
}

