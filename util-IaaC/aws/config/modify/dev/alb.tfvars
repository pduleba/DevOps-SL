##################################################################################
# VARIABLES
##################################################################################

# Relates to init->global.tfvars->bucket
state_bucket = "pduleba-app-terraform"
# Relates to init->dev->vpc.tfvars->key
state_bucket_vpc_key = "dev/vpc.tfstate"
# Relates to init->dev->s3.tfvars->key
state_bucket_s3_key = "dev/s3.tfstate"

state_bucket_access_log_prefix = "alb_access_logs"

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
