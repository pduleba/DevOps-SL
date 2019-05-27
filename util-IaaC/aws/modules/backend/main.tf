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

variable "bucket_policy_principals_identifiers" {
  description = "An AWS S3 bucket access granted IAM users ARN list"
  type = "list"
}

##################################################################################
# DATA
##################################################################################

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "backend_policy_document" {
  statement {

    effect    = "Allow"

    // principals - bucket creator access only by default
    principals {
      type = "AWS"
      identifiers = "${var.bucket_policy_principals_identifiers}"
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${var.bucket}/*"
    ]
  }
}

##################################################################################
# MODULES
##################################################################################

module "commons" {
  source = "../commons"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_s3_bucket" "backend_bucket" {
  bucket        = "${var.bucket}"

  acl           = "private"
  force_destroy = "true"
  policy = "${data.aws_iam_policy_document.backend_policy_document.json}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "backend_bucket"
      )
    ),
    module.commons.tags
  )}"
}

##################################################################################
# OUTPUT
##################################################################################

output "backend_bucket" {
  value = "Backend bucket = ${aws_s3_bucket.backend_bucket.bucket}"
}
