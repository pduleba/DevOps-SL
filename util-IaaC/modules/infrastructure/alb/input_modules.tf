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

module "alb-sg" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.alb_security_group_name_postfix}"
}

module "alb" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "alb"
}

module "target-group-rds" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.target_group_rds_name_postfix}"
}

module "target-group-s3" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.target_group_s3_name_postfix}"
}

module "alb-access-log-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.access_log_bucket_name_postfix}"
}

module "ssm-parameter-http-host" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_http_host_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-http-host"

  description  = "DevOps upskill http host parameter"
}
