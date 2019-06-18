##################################################################################
# DATA
##################################################################################

data "aws_iam_policy" "code_deploy_policy" {
  arn = "${var.deployment_group_policy_arn}"
}

data "aws_sns_topic" "topic" {
  name = "${var.deployment_group_trigger_id}"
}

data "aws_autoscaling_group" "rds" {
  name = "${var.deployment_group_autoscaling_group_rds_id}"
}

data "aws_autoscaling_group" "s3" {
  name = "${var.deployment_group_autoscaling_group_s3_id}"
}

data "aws_iam_policy_document" "code_deploy_assume_role_policy" {
  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codedeploy.amazonaws.com",
      ]
    }
  }
}
