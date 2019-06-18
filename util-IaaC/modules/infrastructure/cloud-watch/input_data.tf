##################################################################################
# DATA
##################################################################################

data "aws_autoscaling_group" "rds" {
  name = "${var.autoscaling_group_rds_name}"
}

data "aws_autoscaling_group" "s3" {
  name = "${var.autoscaling_group_s3_name}"
}

data "aws_sns_topic" "topic" {
  name = "${var.sns_topic_name}"
}
