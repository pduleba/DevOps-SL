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
variable "period" {default = "120"}
variable "statistic" {default = "Average"}
variable "threshold" {default = 80}
variable "treat_missing_data" {default = "ignore"}

variable "autoscaling_group_rds_id" {}
variable "autoscaling_group_s3_id" {}
variable "sns_topic_id" {}
