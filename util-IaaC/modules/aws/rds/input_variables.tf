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

variable "rds_security_group_name_postfix" {
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

