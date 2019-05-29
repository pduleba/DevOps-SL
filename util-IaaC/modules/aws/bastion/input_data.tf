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

data "aws_security_group" "bastion" {
  tags = "${module.bastion-sg.tags}"
}

data "aws_iam_policy" "ssm_policy" {
  arn = "${var.instance_ssm_service_role_arn}"
}

# Location relative to exec/* scripts
data "template_file" "bastion_script" {
  template = "${file("./config/scripts/bastion.tpl")}"
}

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "bastion_s3_policy" {
  statement {

    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListObject"
    ]

    resources = ["arn:aws:s3:::${module.app-bucket.name}/*"]
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
