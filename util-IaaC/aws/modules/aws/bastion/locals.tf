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

locals {
  # VPC
  VPC_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.vpc_id}"

  # Subnet
  SUBNETS_PUBLIC_IDS = "${data.terraform_remote_state.vpc_remote_state.outputs.subnets_public_ids}"

  # Security group
  SECURITY_GROUP_PUBLIC_BASTION_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.security_group_public_bastion_id}"

  # BASTION
  APP_BUCKET = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    var.app_bucket_postfix
  )}"
}
