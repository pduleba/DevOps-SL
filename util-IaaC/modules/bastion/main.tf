##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" { default = "bastion" }

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "bastion_security_group_name_postfix" {}

variable "instance_image_id" {}
variable "instance_type" {}
variable "instance_key_name" {}
variable "instance_user_data_script_path" {}

variable "ssm_policy_arn" {}

variable "app_bucket_postfix" {}

##################################################################################
# MODULES
##################################################################################

module "bastion" {
  source = "./ec2"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                 = "${var.owner}"
  resource_name_prefix  = "${var.resource_name_prefix}"
  resource_name_postfix = "${var.resource_name_postfix}"

  vpc_name_postfix            = "${var.vpc_name_postfix}"
  public_subnet_name_postfix  = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix = "${var.private_subnet_name_postfix}"

  ec2_security_group_name_postfix = "${var.bastion_security_group_name_postfix}"

  instance_image_id              = "${var.instance_image_id}"
  instance_type                  = "${var.instance_type}"
  instance_key_name              = "${var.instance_key_name}"
  instance_user_data_script_path = "${var.instance_user_data_script_path}"

  ssm_policy_arn = "${var.ssm_policy_arn}"

  app_bucket_postfix = "${var.app_bucket_postfix}"
}