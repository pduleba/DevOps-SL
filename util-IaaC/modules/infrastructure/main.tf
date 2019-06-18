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
variable "listener_rule_s3_condition_values" { type = "list" }
variable "listener_rule_rds_condition_values" { type = "list" }

variable "access_log_bucket_name_postfix" {}

variable "launch_configuration_image_id" {}
variable "launch_configuration_instance_type" {}
variable "launch_configuration_key_name" {}
variable "launch_configuration_user_data_template_path" {}

variable "autoscaling_serivce_role_arn" {}
variable "autoscaling_min_size" {}
variable "autoscaling_desired_size" {}
variable "autoscaling_max_size" {}

variable "ssm_parameter_http_host_key_postfix" {}

variable "ssm_policy_arn" {}

variable "sns_delivery_policy_template_path" {}
variable "sns_policy_source_owner_account_id" {}
variable "sns_protocol" {}
variable "sns_endpoint" {}

variable "deployment_group_policy_arn" {}

variable "deployment_config_minimum_healthy_hosts" {}

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

  vpc_name_postfix            = "${var.vpc_name_postfix}"
  public_subnet_name_postfix  = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix = "${var.private_subnet_name_postfix}"

  alb_security_group_name_postfix = "${var.alb_security_group_name_postfix}"

  port     = "${var.port}"
  protocol = "${var.protocol}"

  listener_default_action_redirect_path = "${var.listener_default_action_redirect_path}"
  listener_rule_rds_condition_values    = "${var.listener_rule_rds_condition_values}"
  listener_rule_s3_condition_values     = "${var.listener_rule_s3_condition_values}"

  target_group_deregistration_delay = "${var.target_group_deregistration_delay}"
  target_group_slow_start           = "${var.target_group_slow_start}"
  target_group_rds_name_postfix     = "${var.target_group_rds_name_postfix}"
  target_group_rds_path             = "${var.target_group_rds_path}"
  target_group_s3_name_postfix      = "${var.target_group_s3_name_postfix}"
  target_group_s3_path              = "${var.target_group_s3_path}"

  access_log_bucket_name_postfix = "${var.access_log_bucket_name_postfix}"
  access_log_bucket_log_prefix   = "${var.environment}"

  ssm_parameter_environment_postfix   = "${var.environment}"
  ssm_parameter_http_host_key_postfix = "${var.ssm_parameter_http_host_key_postfix}"
}

module "asg" {
  source = "./asg"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                 = "${var.owner}"
  resource_name_prefix  = "${var.resource_name_prefix}"
  resource_name_postfix = "server"

  vpc_name_postfix            = "${var.vpc_name_postfix}"
  public_subnet_name_postfix  = "${var.public_subnet_name_postfix}"
  private_subnet_name_postfix = "${var.private_subnet_name_postfix}"

  instance_security_group_name_postfix = "${var.ec2_security_group_name_postfix}"

  target_group_rds_arn = "${module.alb.target_group_rds_arn}"
  target_group_s3_arn  = "${module.alb.target_group_s3_arn}"

  launch_configuration_image_id                = "${var.launch_configuration_image_id}"
  launch_configuration_instance_type           = "${var.launch_configuration_instance_type}"
  launch_configuration_key_name                = "${var.launch_configuration_key_name}"
  launch_configuration_user_data_template_path = "${var.launch_configuration_user_data_template_path}"

  autoscaling_serivce_role_arn = "${var.autoscaling_serivce_role_arn}"
  autoscaling_min_size         = "${var.autoscaling_min_size}"
  autoscaling_desired_size     = "${var.autoscaling_desired_size}"
  autoscaling_max_size         = "${var.autoscaling_max_size}"

  ssm_policy_arn = "${var.ssm_policy_arn}"

  app_bucket_postfix = "${var.app_bucket_postfix}"
}

module "sns" {
  source = "./sns"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                 = "${var.owner}"
  resource_name_prefix  = "${var.resource_name_prefix}"
  resource_name_postfix = "sns"

  sns_delivery_policy_template_path  = "${var.sns_delivery_policy_template_path}"
  sns_policy_source_owner_account_id = "${var.sns_policy_source_owner_account_id}"

  sns_protocol = "${var.sns_protocol}"
  sns_endpoint = "${var.sns_endpoint}"
}

module "cloud-watch" {
  source = "./cloud-watch"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                 = "${var.owner}"
  resource_name_prefix  = "${var.resource_name_prefix}"
  resource_name_postfix = "cloud-watch"

  autoscaling_group_rds_id = "${module.asg.autoscaling_group_rds_id}"
  autoscaling_group_s3_id  = "${module.asg.autoscaling_group_s3_id}"
  sns_topic_id             = "${module.sns.topic_id}"
}

module "code-deploy" {
  source = "./code-deploy"

  profile = "${var.profile}"
  region  = "${var.region}"
  bucket  = "${var.bucket}"

  owner                 = "${var.owner}"
  resource_name_prefix  = "${var.resource_name_prefix}"
  resource_name_postfix = "code-deploy"

  deployment_group_policy_arn               = "${var.deployment_group_policy_arn}"
  deployment_group_alarm_names              = "${module.cloud-watch.alarm_names}"
  deployment_group_autoscaling_group_rds_id = "${module.asg.autoscaling_group_rds_id}"
  deployment_group_autoscaling_group_s3_id  = "${module.asg.autoscaling_group_s3_id}"
  deployment_group_trigger_id               = "${module.sns.topic_id}"

  deployment_config_minimum_healthy_hosts = "${var.deployment_config_minimum_healthy_hosts}"
}