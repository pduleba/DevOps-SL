##################################################################################
# TERRAFORM
##################################################################################

terraform {
  # values injected by `name` from file specied on `init` via `-backend-config` parameter
  # not in use by 'plan'/'apply'/'destroy' once initialized
  # for locking use 'lock_table' of AWS DynamoDB - see https://www.terraform.io/docs/backends/types/s3.html#lock_table
  backend "s3" {}
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_alb" "alb" {
  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    "alb"
  )}"

  # Basic Configuration
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"
  // TODO :: Why is it needed?
  subnets = "${concat(
    data.aws_subnet.subnets_private.*.id,
    data.aws_subnet.subnets_public.*.id
  )}"

  # Security groups
  security_groups = "${list(data.aws_security_group.security_group_public_alb.id)}"

  # Attributes
  enable_deletion_protection = false
  idle_timeout               = 60
  enable_http2               = true
  access_logs {
    enabled = true
    bucket  = "${data.aws_s3_bucket.access_log_s3_bucket.bucket}"
    prefix  = "${var.state_bucket_access_log_prefix}"
  }

  # Listeners

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "alb"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"

  default_action {
    type = "redirect"
    redirect {
      port     = "${var.port}"
      protocol = "${var.protocol}"

      host  = "#{host}"
      path  = "${var.listener_default_action_redirect_path}"
      query = "#{query}"

      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener_rule" "alb_listener_rule" {
  # Loop
  count = 2

  listener_arn = "${aws_alb_listener.alb_listener.arn}"
  priority     = "${count.index}"

  condition {
    field  = "path-pattern"
    values = "${count.index < 1 ? var.listener_rule_rds_condition_values : var.listener_rule_s3_condition_values}"
  }

  action {
    type = "forward"
    target_group_arn = "${element(
      aws_alb_target_group.alb_target_groups.*.arn,
      count.index
    )}"
  }
}

resource "aws_alb_target_group" "alb_target_groups" {
  # Loop
  count = 2

  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = "${format(
    "%s-%s",
    module.commons.resource_name_prefix,
    count.index < 1 ? "alb-target-group-rds" : "alb-target-group-s3"
  )}"

  # Configuration
  target_type = "instance"
  protocol    = "${var.protocol}"
  port        = "${var.port}"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  # Delays
  deregistration_delay = 0 // Disable slow deregistration
  slow_start           = 0 // Disable slow start

  # Health check settings
  health_check {
    protocol = "${var.protocol}"
    path     = "${count.index < 1 ? var.target_group_path_rds : var.target_group_path_s3}"

    # Advanced health check settings
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        count.index < 1 ? "alb_target_group_rds" : "alb_target_group_s3"
      )
    ),
    module.commons.tags
  )}"
}
