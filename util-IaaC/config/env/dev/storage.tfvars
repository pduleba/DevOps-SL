##################################################################################
# VARIABLES
##################################################################################

environment = "dev"

# Relates to network.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"

# Aurora MySQL 1.x - https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Updates.20180206.html
rds_engine = "aurora"
rds_engine_mode = "provisioned"
rds_engine_version = "5.6.10a"
rds_instance_class = "db.t2.small"
rds_parameter_group = "aurora5.6"
rds_cluster_parameter_group = "aurora5.6"
rds_security_group_name_postfix = "rds-sg"

database_name = "appdb"
database_username = "user"
database_port = "3306"

ssm_parameter_database_host_key_postfix = "database/host"
ssm_parameter_database_port_key_postfix = "database/port"
ssm_parameter_database_name_key_postfix = "database/name"
ssm_parameter_database_username_key_postfix = "database/username"
ssm_parameter_database_password_key_postfix = "database/password"
