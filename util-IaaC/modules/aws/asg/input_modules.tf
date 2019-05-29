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

module "ec2-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.ec2_security_group_name_postfix}"
}

module "target-group-rds" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.target_group_rds_name_postfix}"
}

module "target-group-s3" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.target_group_s3_name_postfix}"
}

module "autoscaling-group-rds" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "autoscaling-group-rds"
}

module "autoscaling-group-s3" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "autoscaling-group-s3"
}

module "launch-configuration-rds" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "launch-configuration-rds"
}

module "launch-configuration-s3" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "launch-configuration-s3"
}

module "ec2-instance-profile" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "ec2-instance-profile"
}

module "ec2-role" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "ec2-role"
  description  = "DevOps upskill role allowing EC2 to access infrastructure private resources on your behalf."
}

module "ec2-role-policy" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "ec2-role-policy"
}

module "app-bucket" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.app_bucket_postfix}"
}
