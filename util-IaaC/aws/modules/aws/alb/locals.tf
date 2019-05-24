##################################################################################
# LOCALS
##################################################################################

# Intentionally moved here as source fo local variavles interpolation
data "terraform_remote_state" "vpc_remote_state" {
  backend = "s3"

  config = {
    profile = "${var.profile}"
    region  = "${var.region}"
    bucket  = "${var.state_bucket}"
    key     = "${var.state_bucket_vpc_key}"
  }
}
data "terraform_remote_state" "s3_remote_state" {
  backend = "s3"

  config = {
    profile = "${var.profile}"
    region  = "${var.region}"
    bucket  = "${var.state_bucket}"
    key     = "${var.state_bucket_s3_key}"
  }
}

locals {
  # VPC
  VPC_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.vpc_id}"

  # Subnet
  SUBNETS_PRIVATE_IDS = "${data.terraform_remote_state.vpc_remote_state.outputs.subnets_private_ids}"
  SUBNETS_PUBLIC_IDS  = "${data.terraform_remote_state.vpc_remote_state.outputs.subnets_public_ids}"

  # Security group
  SECURITY_GROUP_PUBLIC_ALB_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.security_group_public_alb_id}"

  # ALB
  ACCESS_LOG_BUCKET = "${data.terraform_remote_state.s3_remote_state.outputs.alb_bucket}"
}
