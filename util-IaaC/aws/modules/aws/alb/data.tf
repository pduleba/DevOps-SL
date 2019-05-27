##################################################################################
# DATA
##################################################################################

data "aws_vpc" "vpc" {
  id = "${local.VPC_ID}"
}

data "aws_subnet" "subnets_public" {
  count = "${length(local.SUBNETS_PUBLIC_IDS)}"
  id    = "${local.SUBNETS_PUBLIC_IDS[count.index]}"
}

data "aws_subnet" "subnets_private" {
  count = "${length(local.SUBNETS_PRIVATE_IDS)}"
  id    = "${local.SUBNETS_PRIVATE_IDS[count.index]}"
}

data "aws_security_group" "security_group_public_alb" {
  id = "${local.SECURITY_GROUP_PUBLIC_ALB_ID}"
}

data "aws_iam_policy_document" "access_log_s3_bucket_policy_document" {
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
  statement {

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = "${list(
        var.access_log_alb_owner_account_id
      )}"
    }

    actions = [
      "s3:PutObject"
    ]

    resources = "${list(
      format(
        "arn:aws:s3:::%s/%s/AWSLogs/%s/*",
        local.ACCESS_LOG_S3_BUCKET,
        var.access_log_s3_bucket_log_prefix,
        var.access_log_s3_bucket_owner_account_id
      )
    )}"
  }
}