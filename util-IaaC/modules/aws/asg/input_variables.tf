##################################################################################
# VARIABLES
##################################################################################

variable "profile" {
}

variable "region" {
}

variable "bucket" {
}

variable "owner" {
}

variable "resource_name_prefix" {
}

variable "vpc_name_postfix" {
}

variable "public_subnet_name_postfix" {
}

variable "private_subnet_name_postfix" {
}

variable "ec2_security_group_name_postfix" {
}

variable "target_group_rds_name_postfix" {

}

variable "target_group_s3_name_postfix" {

}

variable "instance_ami" {
  description = "A launch configuration image id"
}

variable "instance_type" {
  description = "A launch configuration instance type"
}

variable "instance_key_pair_name" {
  description = "A launch configuration key pair name"
}

variable "instance_ssm_service_role_arn" {
  description = "An Amazon EC2 service role for SSM ARN"
}

variable "autoscaling_serivce_role_arn" {
  description = "An Amazon EC2 service role for SSM ARN"
}

variable "autoscaling_min_size" {
  description = "An autoscaling group min size"
}

variable "autoscaling_desired_size" {
  description = "An autoscaling group desired size"
}

variable "autoscaling_max_size" {
  description = "An autoscaling group max size"
}

variable "app_bucket_postfix" {
  description = "An AWS S3 bucket application business logic related"
}
