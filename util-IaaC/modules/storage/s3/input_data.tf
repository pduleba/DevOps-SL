##################################################################################
# DATA
##################################################################################

data "aws_iam_policy_document" "access_log_s3_bucket_policy_document" {
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
  statement {

    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    resources = "${list(
      format(
        "arn:aws:s3:::%s/%s/AWSLogs/%s/*",
        module.alb-access-log-bucket.name,
        var.access_log_bucket_log_prefix,
        var.access_log_bucket_owner_account_id
      )
    )}"

    principals {
      type = "AWS"
      identifiers = "${list(
        var.access_log_alb_owner_account_id
      )}"
    }
  }
}