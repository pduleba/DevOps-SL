##################################################################################
# LOCALS
##################################################################################

locals {
  PUBLIC_SUBNET_COUNT = var.az_use_count
  PRIVATE_SUBNET_COUNT = var.az_use_count
  // public & private subnet per AZ
  SUBNET_COUNT = PUBLIC_SUBNET_COUNT + PRIVATE_SUBNET_COUNT
}
