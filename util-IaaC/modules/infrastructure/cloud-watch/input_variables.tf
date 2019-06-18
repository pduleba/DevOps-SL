##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "comparison_operator" {default = "GreaterThanOrEqualToThreshold"}
variable "evaluation_periods" {default = 2}
variable "metric_name" {default = "CPUUtilization"}
variable "namespace" {default = "AWS/EC2"}
variable "period" {default = "300"}
variable "statistic" {default = "Average"}
variable "threshold" {default = 80}
variable "datapoints_to_alarm" {default = 1}
variable "unit" {default = "Percent"}
variable "treat_missing_data" {default = "ignore"}
variable "actions_enabled" {default = true}

variable "autoscaling_group_rds_name" {}
variable "autoscaling_group_s3_name" {}
variable "sns_topic_name" {}
