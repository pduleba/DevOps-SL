##################################################################################
# VARIABLES
##################################################################################

/* *************** VPC CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

variable "flowlog_s3_bucket_postfix" {
  description = "An flow log S3 bucket AWS VPC dedicated"
}
