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

variable "bastion_security_group_name_postfix" {}

variable "instance_ami" {}
variable "instance_type" {}

variable "instance_ssm_service_role_arn" {}
variable "instance_key_pair_name" {}

variable "app_bucket_postfix" {}

##################################################################################
# MODULES
##################################################################################

module "ec2" {
  source = "./ec2"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                = "${var.owner}"
  resource_name_prefix = "${var.resource_name_prefix}"

  vpc_name_postfix                    = "${var.vpc_name_postfix}"
  public_subnet_name_postfix          = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix         = "${var.private_subnet_name_postfix}"

  bastion_security_group_name_postfix = "${var.bastion_security_group_name_postfix}"

  instance_ami = "${var.instance_ami}"
  instance_type = "${var.instance_type}"

  instance_ssm_service_role_arn = "${var.instance_ssm_service_role_arn}"
  instance_key_pair_name = "${var.instance_key_pair_name}"

  app_bucket_postfix = "${var.app_bucket_postfix}"
}