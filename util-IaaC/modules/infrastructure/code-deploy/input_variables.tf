##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "deployment_group_autoscaling_group_rds_name" {}
variable "deployment_group_autoscaling_group_s3_name" {}
variable "deployment_group_policy_arn" {}
variable "deployment_group_trigger_name" {}
variable "deployment_group_trigger_events" {
  type = "list"
  default = [
    "DeploymentStart"
  ]
}
variable "deployment_group_alarm_names" {}
variable "deployment_group_alarm_enabled" {default = true}
variable "deployment_group_alarm_ignore_poll_alarm_failure" {default = true}
variable "deployment_group_auto_rollback_enabled" {default = true}
variable "deployment_group_auto_rollback_events" {
  type = "list"
  default = [
    "DEPLOYMENT_FAILURE",
    "DEPLOYMENT_STOP_ON_ALARM"
  ]
}

variable "deployment_config_minimum_healthy_hosts" {}
variable "deployment_config_time_based_linear_interval" {default = 1}
variable "deployment_config_time_based_linear_percentage" {default = 50}
