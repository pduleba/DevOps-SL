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

variable "alb_security_group_name_postfix" {}
variable "ec2_security_group_name_postfix" {}

variable "protocol" {}
variable "port" {}

variable "target_group_rds_name_postfix" {}
variable "target_group_rds_path" {}
variable "target_group_s3_name_postfix" {}
variable "target_group_s3_path" {}
variable "target_group_deregistration_delay" {}
variable "target_group_slow_start" {}

variable "listener_default_action_redirect_path" {}
variable "listener_rule_s3_condition_values" {type = "list"}
variable "listener_rule_rds_condition_values" {type = "list"}

variable "access_log_bucket_name_postfix" {}
variable "access_log_bucket_log_prefix" {}

variable "instance_ami" {}
variable "instance_type" {}
variable "instance_key_pair_name" {}
variable "instance_ssm_service_role_arn" {}

variable "autoscaling_serivce_role_arn" {}
variable "autoscaling_min_size" {}
variable "autoscaling_desired_size" {}
variable "autoscaling_max_size" {}

variable "app_bucket_postfix" {}

##################################################################################
# MODULES
##################################################################################

module "alb" {
  source = "./alb"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                = "${var.owner}"
  resource_name_prefix = "${var.resource_name_prefix}"

  vpc_name_postfix                    = "${var.vpc_name_postfix}"
  public_subnet_name_postfix          = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix         = "${var.private_subnet_name_postfix}"

  alb_security_group_name_postfix = "${var.alb_security_group_name_postfix}"

  port = "${var.port}"
  protocol = "${var.protocol}"

  listener_default_action_redirect_path = "${var.listener_default_action_redirect_path}"
  listener_rule_rds_condition_values = "${var.listener_rule_rds_condition_values}"
  listener_rule_s3_condition_values = "${var.listener_rule_s3_condition_values}"

  target_group_deregistration_delay = "${var.target_group_deregistration_delay}"
  target_group_slow_start = "${var.target_group_slow_start}"
  target_group_rds_name_postfix = "${var.target_group_rds_name_postfix}"
  target_group_rds_path = "${var.target_group_rds_path}"
  target_group_s3_name_postfix = "${var.target_group_s3_name_postfix}"
  target_group_s3_path = "${var.target_group_s3_path}"

  access_log_bucket_name_postfix = "${var.access_log_bucket_name_postfix}"
  access_log_bucket_log_prefix = "${var.access_log_bucket_log_prefix}"
}

module "asg" {
  source = "./asg"


  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                = "${var.owner}"
  resource_name_prefix = "${var.resource_name_prefix}"

  vpc_name_postfix                    = "${var.vpc_name_postfix}"
  public_subnet_name_postfix          = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix         = "${var.private_subnet_name_postfix}"

  ec2_security_group_name_postfix = "${var.ec2_security_group_name_postfix}"

  target_group_rds_name_postfix = "${var.target_group_rds_name_postfix}"
  target_group_s3_name_postfix = "${var.target_group_s3_name_postfix}"

  instance_ami = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  instance_key_pair_name = "${var.instance_key_pair_name}"
  instance_ssm_service_role_arn = "${var.instance_ssm_service_role_arn}"

  autoscaling_serivce_role_arn = "${var.autoscaling_serivce_role_arn}"
  autoscaling_min_size = "${var.autoscaling_min_size}"
  autoscaling_desired_size = "${var.autoscaling_desired_size}"
  autoscaling_max_size = "${var.autoscaling_max_size}"

  app_bucket_postfix = "${var.app_bucket_postfix}"
}