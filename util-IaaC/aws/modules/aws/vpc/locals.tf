##################################################################################
# LOCALS
##################################################################################

# Intentionally moved here as source of local variavles interpolation
data "terraform_remote_state" "s3_remote_state" {
  backend = "s3"

  config = {
    profile = "${var.profile}"
    region  = "${var.region}"
    bucket  = "${var.state_bucket}"
    key     = "${var.state_bucket_s3_key}"
  }
}

# TODO :: Use https://github.com/pduleba/Terraform-SL/blob/master/01-code-samples/my-ip/main.tf
locals {
  VPC_FLOWLOG_BUCKET      = "${data.terraform_remote_state.s3_remote_state.outputs.vpc_bucket}"
  VPC_CIDR                = "192.168.0.0/16"
  SUBNET_COUNT            = 6
  SUBNET_PUBLIC_COUNT     = 3
  SG_PUBLIC_INGRESS_CIDRs = ["188.114.87.10/32"]
}
