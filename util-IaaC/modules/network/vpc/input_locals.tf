##################################################################################
# LOCALS
##################################################################################

locals {
  PUBLIC_SUBNET_COUNT = var.az_use_count
  PRIVATE_SUBNET_COUNT = var.az_use_count
  // public & private subnet per AZ
  SUBNET_COUNT = local.PUBLIC_SUBNET_COUNT + local.PRIVATE_SUBNET_COUNT
}
