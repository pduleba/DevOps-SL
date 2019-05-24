##################################################################################
# VARIABLES
##################################################################################

/* *************** STATE FILES CONFIGURATION *************** */
variable "state_bucket" {
  description = "A state file S3 bucket VPC name"
}

variable "state_bucket_s3_key" {
  description = "A state file S3 bucket VPC key"
}

/* *************** VPC CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}
