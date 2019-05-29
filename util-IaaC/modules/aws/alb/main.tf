##################################################################################
# RESOURCES
##################################################################################

resource "aws_alb" "alb" {
  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = "${module.alb.name}"

  # Basic Configuration
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"
  // TODO :: This is not needed here - FIX ME
  subnets = "${concat(
    data.aws_subnet.private.*.id,
    data.aws_subnet.public.*.id
  )}"

  # Security groups
  security_groups = "${list(data.aws_security_group.alb.id)}"

  # Attributes
  enable_deletion_protection = false
  idle_timeout               = 60
  enable_http2               = true
  access_logs {
    enabled = true
    bucket  = "${aws_s3_bucket.access_log_s3_bucket.bucket}"
    prefix  = "${var.access_log_bucket_log_prefix}"
  }

  # Listeners

  tags = "${module.alb.tags}"
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
  priority     = "${1 + count.index}" // between 1 - 50000

  condition {
    field  = "path-pattern"
    values = "${count.index % 2 < 1 ? var.listener_rule_rds_condition_values : var.listener_rule_s3_condition_values}"
  }

  action {
    type             = "forward"
    target_group_arn = "${element(aws_alb_target_group.alb_target_groups.*.arn, count.index)}"
  }
}

resource "aws_alb_target_group" "alb_target_groups" {
  # Loop
  count = 2

  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = "${count.index % 2 < 1 ? module.target-group-rds.name : module.target-group-s3.name}"

  # Configuration
  target_type = "instance"
  protocol    = "${var.protocol}"
  port        = "${var.port}"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  # Delays
  deregistration_delay = "${var.target_group_deregistration_delay}"
  slow_start           = "${var.target_group_slow_start}"

  # Health check settings
  health_check {
    protocol = "${var.protocol}"
    path     = "${count.index % 2 < 1 ? module.target-group-rds.path : module.target-group-s3.path}"

    # Advanced health check settings
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = "${count.index % 2 < 1 ? module.target-group-rds.tags : module.target-group-s3.tags}"
}

resource "aws_s3_bucket" "access_log_s3_bucket" {
  bucket = "${module.alb-access-log-bucket.name}"

  acl           = "private"
  force_destroy = "true"
  policy        = "${data.aws_iam_policy_document.access_log_s3_bucket_policy_document.json}"

  tags = "${module.alb-access-log-bucket.tags}"
}
