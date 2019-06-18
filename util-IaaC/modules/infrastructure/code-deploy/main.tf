##################################################################################
# RESOURCES
##################################################################################

resource "aws_codedeploy_app" "application" {
  name = "${module.application.name}"

  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  # Deployment group name
  deployment_group_name = "${module.deployment-group.name}"

  # Application
  app_name = "${aws_codedeploy_app.application.name}"

  # Service role
  service_role_arn = "${aws_iam_role.code_deploy_role.arn}"

  # Deployment type
  deployment_style {
    // TODO :: Verify 'BLUE_GREEN' + 'DISCOVER_EXISTING'
    // https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html#reference-appspec-file-structure-hooks-availability
    deployment_type = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  # Environment configuration (ASG/EC2/On-premise)
  autoscaling_groups = "${list(
    data.aws_autoscaling_group.rds.name,
    data.aws_autoscaling_group.s3.name
  )}"
  dynamic "ec2_tag_filter" {
    for_each = "${module.deployment-group.base_tags}"

    content {
      type                = "KEY_AND_VALUE"
      key                 = ec2_tag_filter.key
      value               = ec2_tag_filter.value
    }
  }

  # Deployment settings
  deployment_config_name = "${aws_codedeploy_deployment_config.deployment_config.id}"

  # Load balancer (where to redirect traffic durring deployment (EC2 traffic blocked during deployment))
  // load_balancer_info = null

  # Triggers
  trigger_configuration {
    trigger_name = "deployment-group-notification"
    trigger_events = "${var.deployment_group_trigger_events}"
    trigger_target_arn = "${data.aws_sns_topic.topic.arn}"
  }

  # Alarms
  alarm_configuration {
    enabled = "${var.deployment_group_alarm_enabled}"
    alarms = "${var.deployment_group_alarm_names}"
    ignore_poll_alarm_failure = "${var.deployment_group_alarm_ignore_poll_alarm_failure}"
  }

  # Rollbacks
  auto_rollback_configuration {
    enabled = "${var.deployment_group_auto_rollback_enabled}"
    events = "${var.deployment_group_auto_rollback_events}"
  }
}

resource "aws_codedeploy_deployment_config" "deployment_config" {
  deployment_config_name = "${module.deployment-config.name}"

  compute_platform = "Server"

  minimum_healthy_hosts {
    type = "HOST_COUNT"
    value = "${var.deployment_config_minimum_healthy_hosts}"
  }

  // Traffic routing configuration should be null for Server deployment configuration
  // traffic_routing_config = null
}

resource "aws_iam_role" "code_deploy_role" {
  name = "${module.code-deploy-role.name}"

  description        = "${module.code-deploy-role.description}"
  assume_role_policy = "${data.aws_iam_policy_document.code_deploy_assume_role_policy.json}"

  tags = "${module.code-deploy-role.tags}"
}

resource "aws_iam_role_policy_attachment" "role_attach_amazon_code_deploy_policy" {
  role       = "${aws_iam_role.code_deploy_role.id}"
  policy_arn = "${data.aws_iam_policy.code_deploy_policy.arn}"
}
