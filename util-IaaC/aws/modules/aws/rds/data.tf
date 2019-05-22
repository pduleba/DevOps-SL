##################################################################################
# DATA
##################################################################################

data "terraform_remote_state" "vpc_remote_state" {
  backend = "s3"

  config {
    profile = "${var.profile}"
    region  = "${var.region}"
    bucket  = "${var.bucket}"
    key     = "${var.key_vpc_state}"
  }
}

data "aws_vpc" "vpc" {
  id = "${data.terraform_remote_state.vpc_remote_state.vpc_id}"
}

data "aws_subnet" "subnets_public" {
  count = "${length(data.terraform_remote_state.vpc_remote_state.subnets_public_ids)}"
  id    = "${data.terraform_remote_state.vpc_remote_state.subnets_public_ids[count.index]}"
}

data "aws_subnet" "subnets_private" {
  count = "${length(data.terraform_remote_state.vpc_remote_state.subnets_private_ids)}"
  id    = "${data.terraform_remote_state.vpc_remote_state.subnets_private_ids[count.index]}"
}

data "aws_security_group" "security_group_public" {
  id = "${data.terraform_remote_state.vpc_remote_state.security_group_public_id}"
}

data "aws_security_group" "security_group_private" {
  id = "${data.terraform_remote_state.vpc_remote_state.security_group_private_id}"
}
