##################################################################################
# MODULES
##################################################################################

module "vpc" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.vpc_name_postfix}"
}

module "public-subnet" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.public_subnet_name_postfix}"
}

module "private-subnet" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.private_subnet_name_postfix}"
}

module "rds-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.rds_security_group_name_postfix}"
}

module "password-generator" {
  source = "../../commons/password"
  length = "10"
}

module "aurora-cluster" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster"
}

module "aurora-cluster-instance" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster-instance"
}

module "aurora-subnet-group" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-subnet-group"
  description  = "DevOps upskill AWS Aurora subnet group"
}

module "aurora-cluster-parameter-group" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-cluster-parameter-group"
  description  = "DevOps upskill AWS Aurora cluster parameter group"
}

module "aurora-parameter-group" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "aurora-parameter-group"
  description  = "DevOps upskill AWS RDS parameter group"
}
