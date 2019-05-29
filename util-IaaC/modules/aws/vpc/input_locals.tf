##################################################################################
# LOCALS
##################################################################################

# TODO :: Use https://github.com/pduleba/Terraform-SL/blob/master/01-code-samples/my-ip/main.tf
locals {
  VPC_CIDR                = "192.168.0.0/16"
  SUBNET_COUNT            = 6
  SUBNET_PUBLIC_COUNT     = 3
  SG_PUBLIC_INGRESS_CIDRs = ["188.114.87.10/32"]
}
