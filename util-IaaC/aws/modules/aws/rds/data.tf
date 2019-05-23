##################################################################################
# DATA
##################################################################################

data "aws_vpc" "vpc" {
  id = "${local.VPC_ID}"
}

data "aws_subnet" "subnets_private" {
  count = "${length(local.SUBNETS_PRIVATE_IDS)}"
  id    = "${local.SUBNETS_PRIVATE_IDS[count.index]}"
}

data "aws_security_group" "security_group_private_rds" {
  id = "${local.SECURITY_GROUP_PRIVATE_RDS_ID}"
}
