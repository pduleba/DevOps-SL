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

/* *************** RDS CONFIGURATION *************** */
variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of application infrastructure (including Terraform state)"
}

variable "rds_engine" {
  description = "An AWS RDS engine"
}

variable "rds_engine_mode" {
  description = "An AWS RDS engine mode"
}

variable "rds_engine_version" {
  description = "An AWS RDS engine version"
}

variable "rds_instance_class" {
  description = "An AWS RDS instance class to use (related to CPU and memory)"
}

variable "rds_parameter_group" {
  description = "The DB parameter group"
}

variable "rds_cluster_parameter_group" {
  description = "The DB Cluster parameter group"
}

variable "database_name" {
  description = "An AWS RDS database name"
}

variable "database_username" {
  description = "An AWS RDS database master user name"
}

variable "database_port" {
  description = "An AWS RDS database port number"
}
