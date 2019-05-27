##################################################################################
# DATA
##################################################################################

data "aws_vpc" "vpc" {
  id = "${local.VPC_ID}"
}

data "aws_subnet" "public" {
  id = "${local.SUBNETS_PUBLIC_IDS[0]}"
}

data "aws_security_group" "security_group_public_bastion" {
  id = "${local.SECURITY_GROUP_PUBLIC_BASTION_ID}"
}

data "aws_iam_policy" "bastion_ssm_policy" {
  arn = "${var.amazon_service_role_arn}"
}

# Location relative to exec/* scripts
data "template_file" "bastion_init_script" {
  template = "${file("./modules/aws/bastion/init.tpl")}"
}

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "bastion_s3_policy" {
  statement {

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListObject"
    ]

    resources = ["arn:aws:s3:::${local.APP_BUCKET}/*"]
  }
}

data "aws_iam_policy_document" "bastion_assume_role_policy" {
  statement {

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}
