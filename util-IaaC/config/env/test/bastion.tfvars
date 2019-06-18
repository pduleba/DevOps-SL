##################################################################################
# VARIABLES
##################################################################################

# Relates to network.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"

bastion_security_group_name_postfix = "bastion-sg"

instance_image_id = "ami-0c6b1d09930fac512"
instance_type = "t2.micro"
instance_key_name = "pduleba_ec2_linux_us-east-1_key"
instance_user_data_template_path = "./../../config/templates/ec2_bastion_user_data.tpl"

ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

# Relates to storage.tfvars
app_bucket_postfix = "app-bucket"
