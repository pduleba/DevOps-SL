##################################################################################
# MODULES
##################################################################################

module "flowlog-cloudwatch-role-policy" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "flowlog-cloudwatch-role-policy"
}

module "flowlog-cloudwatch-role" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "flowlog-cloudwatch-role"
  description  = "DevOps upskill role allowing VPC to call CloudWatchFlowLogs service on your behalf."
}

module "cloudwatch-log-group" {
  source = "../../commons/resource"

  owner              = "${var.owner}"
  name_prefix        = "/aws/vpc/flowlogs"
  name_delimiter     = "/"
  name_postfix       = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_prefix    = "${var.resource_name_prefix}"
  tag_name_postfix   = "cloudwatch-log-group"
}

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

module "igw" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "igw"
}

module "ngw-eip" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "ngw-eip"
}

module "ngw" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "ngw"
}

module "public-rt" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "public-rt"
}

module "private-rt" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "private-rt"
}

module "public-acl" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "public-acl"
}

module "private-acl" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "private-acl"
}

module "alb-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.alb_security_group_name_postfix}"
  description  = "DevOps upskill security group ALB intended"
}

module "bastion-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.bastion_security_group_name_postfix}"
  description  = "DevOps upskill security group BASTION intended"
}

module "ec2-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.ec2_security_group_name_postfix}"
  description  = "DevOps upskill security group EC2 intended"
}

module "rds-sg" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.rds_security_group_name_postfix}"
  description  = "DevOps upskill security group RDS intended"
}

module "vpc-flowlog-bucket" {
  source = "../../commons/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.flowlog_bucket_postfix}"
}
