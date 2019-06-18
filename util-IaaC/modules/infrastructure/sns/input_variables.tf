##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "sns_delivery_policy_template_path" {}
variable "sns_policy_source_owner_account_id" {}

variable "endpoint_auto_confirms" {default = true}
variable "confirmation_timeout_in_minutes" {default = 1}
variable "raw_message_delivery" {default = false}

variable "sns_protocol" {}
variable "sns_endpoint" {}
