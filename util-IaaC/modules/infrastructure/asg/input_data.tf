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

data "aws_security_group" "ec2" {
  tags = "${module.ec2-sg.tags}"
}

data "aws_alb_target_group" "rds_target_group" {
  name = "${module.target-group-rds.name}"
}

data "aws_alb_target_group" "s3_target_group" {
  name = "${module.target-group-s3.name}"
}

data "aws_iam_policy" "ssm_policy" {
  arn = "${var.instance_ssm_service_role_arn}"
}

data "aws_s3_bucket" "app_bucket" {
  bucket = "${module.app-bucket.name}"
}

# Location relative to exec/* scripts
data "template_file" "ec2_script" {
  template = "${file("./config/scripts/ec2.tpl")}"
}

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "ec2_s3_policy" {
  statement {

    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = ["arn:aws:s3:::${data.aws_s3_bucket.app_bucket.bucket}/*"]
  }
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
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
