##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

##################################################################################
# VARIABLES
##################################################################################

variable "profile" {
  description = "A AWS CLI profile to be used by Terraform as source of credentials for AWS API calls"
}

variable "region" {
  description = "An AWS region of AWS S3 bucket"
}

variable "bucket" {
  description = "An AWS S3 bucket for storing Terraform state"
}

##################################################################################
# DATA
##################################################################################

# https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-cwl.html
# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = ["s3:*"]
    effect    = "Allow"
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.bucket}/*"
    ]
  }
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket}"

  acl           = "private"
  force_destroy = "true"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"

  tags = "${
    merge(
      map("Name", "pduleba_s3_bucket"),
      map("Owner", "pduleba")
    )
  }"
}

##################################################################################
# OUTPUT
##################################################################################

output "bucket" {
  value = "State bucket ARN = ${aws_s3_bucket.bucket.arn}"
}
