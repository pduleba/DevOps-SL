##################################################################################
# RESOURCES
##################################################################################

resource "aws_autoscaling_group" "autoscaling_groups" {
  # Loop
  count = 2

  # Details
  name = "${count.index % 2 < 1 ? module.autoscaling-group-rds.name : module.autoscaling-group-s3.name}"
  launch_configuration = "${element(
    aws_launch_configuration.launch_configurations.*.name,
    count.index % 2
  )}"
  desired_capacity = "${var.autoscaling_desired_size}" // can be replaced by 'aws_autoscaling_policy'
  max_size         = "${var.autoscaling_max_size}"
  min_size         = "${var.autoscaling_min_size}"
  // TODO :: Use all AZs in region ?
  vpc_zone_identifier = "${data.aws_subnet.private.*.id}"
  availability_zones  = "${data.aws_subnet.private.*.availability_zone_id}"
  target_group_arns = "${list(
    count.index % 2 < 1 ?
    data.aws_alb_target_group.target_group_rds.arn :
    data.aws_alb_target_group.target_group_s3.arn
  )}"
  health_check_type         = "ELB"
  health_check_grace_period = 300
  protect_from_scale_in     = true
  termination_policies = [
    "OldestInstance",
    "Default"
  ]
  suspended_processes = []
  placement_group     = null
  default_cooldown    = 300
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize"
  ]
  metrics_granularity = "1Minute"

  service_linked_role_arn = "${var.autoscaling_serivce_role_arn}"

  # Scaling Policies
  // Use 'aws_autoscaling_policy' for manual or dynamic (policy-based) scaling

  # Instances

  # Monitoring

  # Notifications
  // Use 'aws_autoscaling_notification'

  # Scheduled Actions
  // Use 'aws_autoscaling_schedule'

  # Lifecycle hooks
  // Use 'initial_lifecycle_hook' & 'aws_autoscaling_lifecycle_hook'

  # Other
  force_delete = true
  // Waiting for ASG Capacity (in seconds)
  wait_for_capacity_timeout = "0" // skip ASG capacity waiting behaviour
  // Waiting for ELB Capacity (in instance number)
  min_elb_capacity      = "${var.autoscaling_min_size}"
  wait_for_elb_capacity = "0" // skip ELB capacity waiting behaviour

  # Tags
  dynamic "tag" {
    for_each = "${count.index % 2 < 1 ? module.autoscaling-group-rds.tags : module.autoscaling-group-s3.tags}"

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "launch_configurations" {
  # Loop
  count = 2

  # AMI
  image_id = "${var.launch_configuration_image_id}"

  # Instance type
  instance_type = "${var.launch_configuration_instance_type}"

  # Configure instance
  name                        = "${count.index % 2 < 1 ? module.launch-configuration-rds.name : module.launch-configuration-s3.name}"
  iam_instance_profile        = "${aws_iam_instance_profile.ec2_instance_profile.name}"
  enable_monitoring           = false
  associate_public_ip_address = false

  # Storage
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  # Security groups
  security_groups = "${list(data.aws_security_group.instance.id)}"

  # Review
  key_name = "${var.launch_configuration_key_name}"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${module.instance-profile.name}"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_iam_role" "ec2_role" {
  name = "${module.instance-role.name}"

  description        = "${module.instance-role.description}"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  tags = "${module.instance-role.tags}"
}

resource "aws_iam_role_policy" "ec2_s3_inline_policy" {
  name = "${module.instance-s3-inline-policy.name}"


  role   = "${aws_iam_role.ec2_role.id}"
  policy = "${data.aws_iam_policy_document.instance_s3_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_attach_amazon_ssm_policy" {
  role       = "${aws_iam_role.ec2_role.id}"
  policy_arn = "${data.aws_iam_policy.ssm_policy.arn}"
}
