##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "rds_security_group_name_postfix" {}

variable "rds_engine" {}
variable "rds_engine_mode" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_parameter_group" {}
variable "rds_cluster_parameter_group" {}

variable "database_name" {}
variable "database_username" {}
variable "database_port" {}
