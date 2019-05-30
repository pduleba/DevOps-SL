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

app_bucket_postfix = "app-bucket"

# https://docs.aws.amazon.com/console/elasticloadbalancing/access-logs
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
access_log_bucket_name_postfix = "alb-bucket"
access_log_bucket_log_prefix = "dev"
access_log_bucket_owner_account_id = "890769921003"
access_log_alb_owner_account_id = "127311923021"  // region related
