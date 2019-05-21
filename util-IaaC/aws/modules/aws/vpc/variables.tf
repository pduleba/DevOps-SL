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

variable "tags" {
  description = "A map of common tags to add to all resources"
  type        = "map"

  default = {
    Owner = "pduleba"
  }
}
