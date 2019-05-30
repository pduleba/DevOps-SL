##################################################################################
# VARIABLES
##################################################################################

vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"

alb_security_group_name_postfix = "alb-sg"
bastion_security_group_name_postfix = "bastion-sg"
ec2_security_group_name_postfix = "ec2-sg"
rds_security_group_name_postfix = "rds-sg"

# TODO :: Use https://github.com/pduleba/Terraform-SL/blob/master/01-code-samples/my-ip/main.tf
vpc_cidr = "192.168.0.0/16"
subnet_count = "6"
subnet_public_count = "3"
ingress_cidrs = ["188.114.87.10/32"]

flowlog_bucket_postfix = "vpc-bucket"
