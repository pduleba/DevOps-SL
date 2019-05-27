##################################################################################
# VARIABLES
##################################################################################

# Relates to init->global.tfvars->bucket
state_bucket = "pduleba-app-terraform"
# Relates to init->dev->vpc.tfvars->key
state_bucket_vpc_key = "dev/vpc.tfstate"

protocol = "HTTP"
port = "8080"

target_group_path_s3 = "/app-rest/api/s3/ping"
target_group_path_rds = "/app-rest/api/rds/ping"

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
access_log_s3_bucket_log_prefix = "dev"
access_log_s3_bucket_name_postfix = "alb-bucket"
access_log_s3_bucket_owner_account_id = "890769921003"
access_log_alb_owner_account_id = "127311923021"  // region related
