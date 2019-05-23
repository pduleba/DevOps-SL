##################################################################################
# LOCALS
##################################################################################

# Intentionally moved here as source fo local variavles interpolation
data "terraform_remote_state" "vpc_remote_state" {
  backend = "s3"

  config = {
    profile = "${var.profile}"
    region  = "${var.region}"
    bucket  = "${var.bucket_vpc_state}"
    key     = "${var.key_vpc_state}"
  }
}

resource "random_string" "master_password" {
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html
  length           = 10
  upper            = true
  min_upper        = 1
  lower            = true
  min_lower        = 1
  number           = true
  min_numeric      = 1
  special          = true
  min_special      = 1
  override_special = "!"
}

locals {
  # VPC
  VPC_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.vpc_id}"

  # Subnet
  SUBNETS_PRIVATE_IDS = "${data.terraform_remote_state.vpc_remote_state.outputs.subnets_private_ids}"

  # Security group
  SECURITY_GROUP_PRIVATE_RDS_ID = "${data.terraform_remote_state.vpc_remote_state.outputs.security_group_private_rds_id}"

  # RDS
  RDS_IDENTIFIER = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    "appdb"
  )}"
  MASTER_PASSWORD              = "${random_string.master_password.result}"
  PREFERRED_MAINTENANCE_WINDOW = "sun:01:00-sun:05:00"
  PREFERRED_BACKUP_WINDOW      = "05:00-07:00"
  BACKUP_RETENTION_PERIOD      = 1

}
