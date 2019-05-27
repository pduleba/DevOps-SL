##################################################################################
# VARIABLES
##################################################################################

# Relates to init->global.tfvars->bucket
state_bucket = "pduleba-app-terraform"
# Relates to init->test->vpc.tfvars->key
state_bucket_vpc_key = "test/vpc.tfstate"

instance_ami = "ami-0c6b1d09930fac512"
instance_type = "t2.micro"

amazon_service_role_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

key_pair_name = "pduleba_ec2_linux_us-east-1_key"

# Relates to modify->asg.tfvars->app_bucket_postfix
app_bucket_postfix = "app-bucket"