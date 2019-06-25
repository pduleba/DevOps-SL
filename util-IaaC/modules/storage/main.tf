##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "environment" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "rds_engine" {}
variable "rds_engine_mode" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_parameter_group" {}
variable "rds_cluster_parameter_group" {}
variable "rds_security_group_name_postfix" {}

variable "database_name" {}
variable "database_username" {}
variable "database_port" {}

variable "ssm_parameter_database_host_key_postfix" {}
variable "ssm_parameter_database_port_key_postfix" {}
variable "ssm_parameter_database_name_key_postfix" {}
variable "ssm_parameter_database_username_key_postfix" {}
variable "ssm_parameter_database_password_key_postfix" {}

##################################################################################
# MODULES
##################################################################################

module "rds" {
  source = "./rds"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                             = "${var.owner}"
  resource_name_prefix              = "${var.resource_name_prefix}"
  ssm_parameter_environment_postfix = "${var.environment}"

  vpc_name_postfix            = "${var.vpc_name_postfix}"
  public_subnet_name_postfix  = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix = "${var.private_subnet_name_postfix}"

  rds_engine                      = "${var.rds_engine}"
  rds_engine_mode                 = "${var.rds_engine_mode}"
  rds_engine_version              = "${var.rds_engine_version}"
  rds_instance_class              = "${var.rds_instance_class}"
  rds_parameter_group             = "${var.rds_parameter_group}"
  rds_cluster_parameter_group     = "${var.rds_cluster_parameter_group}"
  rds_security_group_name_postfix = "${var.rds_security_group_name_postfix}"

  database_name     = "${var.database_name}"
  database_username = "${var.database_username}"
  database_port     = "${var.database_port}"

  ssm_parameter_database_host_key_postfix     = "${var.ssm_parameter_database_host_key_postfix}"
  ssm_parameter_database_port_key_postfix     = "${var.ssm_parameter_database_port_key_postfix}"
  ssm_parameter_database_name_key_postfix     = "${var.ssm_parameter_database_name_key_postfix}"
  ssm_parameter_database_username_key_postfix = "${var.ssm_parameter_database_username_key_postfix}"
  ssm_parameter_database_password_key_postfix = "${var.ssm_parameter_database_password_key_postfix}"
}
