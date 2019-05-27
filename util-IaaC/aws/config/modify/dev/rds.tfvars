##################################################################################
# VARIABLES
##################################################################################

# Relates to init->global.tfvars->bucket
state_bucket = "pduleba-app-terraform"
# Relates to init->dev->vpc.tfvars->key
state_bucket_vpc_key = "dev/vpc.tfstate"

# Aurora MySQL 1.x - https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Updates.20180206.html
rds_engine = "aurora"
rds_engine_mode = "provisioned"
rds_engine_version = "5.6.10a"
rds_instance_class = "db.t2.small"
rds_parameter_group = "aurora5.6"
rds_cluster_parameter_group = "aurora5.6"

database_name = "appdb"
database_username = "user"
database_port = "3306"