##################################################################################
# VARIABLES
##################################################################################

environment = "test"

# Relates to network.tfvars
vpc_name_postfix = "vpc"
public_subnet_name_postfix = "public-subnet"
private_subnet_name_postfix = "private-subnet"

alb_security_group_name_postfix = "alb-sg"
ec2_security_group_name_postfix = "ec2-sg"

protocol = "HTTP"
port = "8080"

target_group_rds_name_postfix = "target-group-rds"
target_group_rds_path = "/app-rest/api/rds/ping"
target_group_s3_name_postfix = "target-group-s3"
target_group_s3_path = "/app-rest/api/s3/ping"
target_group_deregistration_delay = 300
target_group_slow_start = 300

listener_default_action_redirect_path = "/app-rest/s3/index"
listener_rule_rds_condition_values = [
  "/app-rest/api/rds/*",
  "/app-rest/rds/*"
]
listener_rule_s3_condition_values = [
  "/app-rest/api/s3/*",
  "/app-rest/s3/*"
]

# https://docs.aws.amazon.com/console/elasticloadbalancing/access-logs
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
# Relates to storage.tfvars
access_log_bucket_name_postfix = "alb-bucket"

launch_configuration_image_id = "ami-0c6b1d09930fac512"
launch_configuration_instance_type = "t2.micro"
launch_configuration_key_name = "pduleba_ec2_linux_us-east-1_key"
launch_configuration_user_data_template_path = "./../../config/templates/launch_configuration_user_data.tpl"

autoscaling_serivce_role_arn = "arn:aws:iam::890769921003:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
autoscaling_min_size = 1
autoscaling_desired_size = 1
autoscaling_max_size = 1

ssm_parameter_http_host_key_postfix = "http/host"

ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

sns_delivery_policy_template_path = "./../../config/templates/delivery_policy.tpl.json"
sns_policy_source_owner_account_id = "890769921003"
sns_protocol = "sms"
sns_endpoint = "+48697250630"

# https://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-create-service-role.html
deployment_group_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"

deployment_config_minimum_healthy_hosts = 1

# Relates to storage.tfvars
app_bucket_postfix = "app-bucket"
