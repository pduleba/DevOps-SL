##################################################################################
# VARIABLES
##################################################################################

# Relates to vpc.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"
ec2_security_group_name_postfix = "ec2-sg"
# Relates to alb.tfvars
target_group_rds_name_postfix = "target-group-rds"
target_group_s3_name_postfix = "target-group-s3"

instance_ami = "ami-0c6b1d09930fac512"
instance_type = "t2.micro"
instance_key_pair_name = "pduleba_ec2_linux_us-east-1_key"
instance_ssm_service_role_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

autoscaling_serivce_role_arn = "arn:aws:iam::890769921003:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
autoscaling_min_size = 1
autoscaling_desired_size = 1
autoscaling_max_size = 1

# Relates to bastion.tfvars
app_bucket_postfix = "app-bucket"
