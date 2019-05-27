##################################################################################
# VARIABLES
##################################################################################

/* *************** ASG CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

variable "app_bucket_postfix" {
  description = "An AWS S3 bucket application business logic related "
}
