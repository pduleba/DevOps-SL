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

data "aws_iam_policy_document" "bucket_policies" {
  # Loop
  count = "${length(local.BUCKETS)}"

  statement {
    actions = ["s3:*"]
    effect  = "Allow"
    // TODO restrict access for specific user
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = "${list(
      format(
        "%s%s%s",
        "arn:aws:s3:::",
        element(
          local.BUCKETS,
          count.index
        ),
        "/*"
      )
    )}"
  }
}

resource "aws_s3_bucket" "buckets" {
  # Loop
  count = "${length(local.BUCKETS)}"

  bucket = "${element(
    local.BUCKETS,
    count.index
  )}"

  acl           = "private"
  force_destroy = "true"
  policy = "${element(
    data.aws_iam_policy_document.bucket_policies.*.json,
    count.index
  )}"

  tags = "${merge(
    map(
      "Name",
      element(
        local.BUCKETS,
        count.index
      )
    ),
    module.commons.tags
  )}"
}
