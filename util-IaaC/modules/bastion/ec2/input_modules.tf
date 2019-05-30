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

module "bastion-sg" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.bastion_security_group_name_postfix}"
}

module "bastion" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "bastion"
}

module "bastion-ebs" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "bastion-ebs"
}

module "bastion-instance-profile" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "bastion-instance-profile"
}

module "bastion-role" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "bastion-role"
  description  = "DevOps upskill role allowing BASTION to access infrastructure private resources on your behalf."
}

module "bastion-s3-inline-policy" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "bastion-s3-inline-policy"
}

module "app-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.app_bucket_postfix}"
}
