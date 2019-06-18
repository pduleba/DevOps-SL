##################################################################################
# DATA
##################################################################################

data "aws_autoscaling_group" "rds" {
  name = "${var.autoscaling_group_rds_id}"
}

data "aws_autoscaling_group" "s3" {
  name = "${var.autoscaling_group_s3_id}"
}

data "aws_sns_topic" "topic" {
  name = "${var.sns_topic_id}"
}
