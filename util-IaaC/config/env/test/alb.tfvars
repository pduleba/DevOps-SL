##################################################################################
# VARIABLES
##################################################################################

# Relates to vpc.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"
alb_security_group_name_postfix = "alb-sg"

protocol = "HTTP"
port = "8080"

target_group_deregistration_delay = 300
target_group_slow_start = 300

target_group_rds_name_postfix = "target-group-rds"
target_group_rds_path = "/app-rest/api/rds/ping"

target_group_s3_name_postfix = "target-group-s3"
target_group_s3_path = "/app-rest/api/s3/ping"

listener_default_action_redirect_path = "/app-rest/s3/index"
listener_rule_s3_condition_values = [
  "/app-rest/api/s3/*",
  "/app-rest/s3/*"
]
listener_rule_rds_condition_values = [
  "/app-rest/api/rds/*",
  "/app-rest/rds/*"
]

# https://docs.aws.amazon.com/console/elasticloadbalancing/access-logs
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
access_log_bucket_name_postfix = "alb-bucket"
access_log_bucket_log_prefix = "test"
access_log_bucket_owner_account_id = "890769921003"
access_log_alb_owner_account_id = "127311923021"  // region related
