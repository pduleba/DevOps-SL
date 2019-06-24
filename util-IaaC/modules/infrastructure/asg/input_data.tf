##################################################################################
# DATA
##################################################################################

data "aws_vpc" "vpc" {
  tags = "${module.vpc.tags}"
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  tags   = "${module.public-subnet.tags}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  tags   = "${module.private-subnet.tags}"
}

data "aws_subnet" "public" {
  id    = "${tolist(data.aws_subnet_ids.public.ids)[count.index]}"
  count = "${length(data.aws_subnet_ids.public.ids)}"
}

data "aws_subnet" "private" {
  id    = "${tolist(data.aws_subnet_ids.private.ids)[count.index]}"
  count = "${length(data.aws_subnet_ids.private.ids)}"
}

data "aws_security_group" "instance" {
  tags = "${module.instance-security-group.tags}"
}

data "aws_alb_target_group" "target_group_rds" {
  arn = "${var.target_group_rds_arn}"
}

data "aws_alb_target_group" "target_group_s3" {
  arn = "${var.target_group_s3_arn}"
}

data "aws_iam_policy" "ssm_policy" {
  arn = "${var.ssm_policy_arn}"
}

data "aws_s3_bucket" "app_bucket" {
  bucket = "${module.app-bucket.name}"
}

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "instance_s3_policy" {
  statement {

    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = ["arn:aws:s3:::${data.aws_s3_bucket.app_bucket.bucket}/*"]
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}
