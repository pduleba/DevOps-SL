##################################################################################
# VARIABLES
##################################################################################

# Relates to network.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"

rds_security_group_name_postfix = "rds-sg"

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

ssm_parameter_database_host_key_postfix = "test/database/host"
ssm_parameter_database_port_key_postfix = "test/database/port"
ssm_parameter_database_name_key_postfix = "test/database/name"
ssm_parameter_database_username_key_postfix = "test/database/username"
ssm_parameter_database_password_key_postfix = "test/database/password"
ssm_parameter_app_bucket_key_postfix = "test/s3/app-bucket"

app_bucket_postfix = "app-bucket"

# https://docs.aws.amazon.com/console/elasticloadbalancing/access-logs
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
access_log_bucket_name_postfix = "alb-bucket"
access_log_bucket_log_prefix = "test"
access_log_bucket_owner_account_id = "890769921003"
access_log_alb_owner_account_id = "127311923021"  // region related
