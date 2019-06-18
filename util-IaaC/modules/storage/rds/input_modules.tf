##################################################################################
# MODULES
##################################################################################

module "vpc" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.vpc_name_postfix}"
}

module "public-subnet" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.public_subnet_name_postfix}"
}

module "private-subnet" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.private_subnet_name_postfix}"
}

module "rds-sg" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.rds_security_group_name_postfix}"
}

module "password-generator" {
  source = "../../utils/password"
  length = "10"
}

module "aurora-cluster" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster"
}

module "aurora-cluster-instance" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster-instance"
}

module "aurora-subnet-group" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-subnet-group"
  description  = "DevOps upskill AWS Aurora subnet group"
}

module "aurora-cluster-parameter-group" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster-parameter-group"
  description  = "DevOps upskill AWS Aurora cluster parameter group"
}

module "aurora-parameter-group" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-parameter-group"
  description  = "DevOps upskill AWS RDS parameter group"
}

module "ssm-parameter-database-host" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_database_host_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-database-host"

  description  = "DevOps upskill AWS RDS host parameter"
}

module "ssm-parameter-database-port" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_database_port_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-database-port"

  description  = "DevOps upskill AWS RDS port parameter"
}

module "ssm-parameter-database-name" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_database_name_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-database-name"

  description  = "DevOps upskill AWS RDS database name parameter"
}

module "ssm-parameter-database-username" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_database_username_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-database-username"

  description  = "DevOps upskill AWS RDS master user name parameter"
}

module "ssm-parameter-database-password" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_database_password_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-database-password"

  description  = "DevOps upskill AWS RDS master user password parameter"
}
