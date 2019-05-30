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
variable "bastion_security_group_name_postfix" {}
variable "ec2_security_group_name_postfix" {}
variable "rds_security_group_name_postfix" {}

variable "vpc_cidr" {}
variable "subnet_count" {}
variable "subnet_public_count" {}
variable "ingress_cidrs" {}

variable "flowlog_bucket_postfix" {}