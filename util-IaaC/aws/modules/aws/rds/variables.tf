##################################################################################
# VARIABLES
##################################################################################

/* *************** RDS CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

/* *************** VPC STATE CONFIGURATION *************** */
variable "bucket" {
  description = "An AWS S3 bucket of Terraform state file"
}

variable "key_vpc_state" {
  description = "An AWS S3 key of Terraform state file"
}
