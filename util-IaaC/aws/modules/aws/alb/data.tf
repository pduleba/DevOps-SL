##################################################################################
# DATA
##################################################################################

data "aws_vpc" "vpc" {
  id = "${local.VPC_ID}"
}

data "aws_subnet" "subnets_public" {
  count = "${length(local.SUBNETS_PUBLIC_IDS)}"
  id    = "${local.SUBNETS_PUBLIC_IDS[count.index]}"
}

data "aws_subnet" "subnets_private" {
  count = "${length(local.SUBNETS_PRIVATE_IDS)}"
  id    = "${local.SUBNETS_PRIVATE_IDS[count.index]}"
}

data "aws_security_group" "security_group_public_alb" {
  id = "${local.SECURITY_GROUP_PUBLIC_ALB_ID}"
}

data "aws_s3_bucket" "access_log_s3_bucket" {
  bucket = "${local.ACCESS_LOG_BUCKET}"
}
