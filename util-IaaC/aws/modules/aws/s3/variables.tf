##################################################################################
# VARIABLES
##################################################################################

/* *************** S3 CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

variable "vpc_bucket_postfix" {
  description = "An AWS VPC dedicated bucket name postfix i.e. for flow logs"
}

variable "alb_bucket_postfix" {
  description = "An AWS ALB dedicated bucket name postfix i.e. for access logs"
}

variable "app_bucket_postfix" {
  description = "An AWS ALB dedicated bucket name postfix i.e. for access logs"
}
