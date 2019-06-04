##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "instance" {
  # AMI
  ami = "${var.instance_image_id}"

  # Instance type
  instance_type = "${var.instance_type}"

  # Configure instance
  subnet_id                   = "${element(data.aws_subnet.public.*.id, 0)}"
  associate_public_ip_address = true
  placement_group             = null // no placement group by default
  credit_specification {
    cpu_credits = "standard"
  }
  iam_instance_profile                 = "${aws_iam_instance_profile.instance_profile.name}"
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination              = false
  monitoring                           = false
  tenancy                              = "default"
  source_dest_check                    = true
  user_data                            = "${data.template_file.user_data.rendered}"

  # Storage
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  # Security groups
  vpc_security_group_ids = "${list(data.aws_security_group.instance.id)}"

  # Review
  key_name = "${var.instance_key_name}"

  # Tags
  volume_tags = "${module.instance-ebs.tags}"
  tags        = "${module.instance.tags}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${module.instance-profile.name}"
  role = "${aws_iam_role.instance_role.name}"
}

resource "aws_iam_role" "instance_role" {
  name = "${module.instance-role.name}"

  description        = "${module.instance-role.description}"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"

  tags = "${module.instance-role.tags}"
}

resource "aws_iam_role_policy" "instance_s3_inline_policy" {
  name = "${module.instance-s3-inline-policy.name}"


  role   = "${aws_iam_role.instance_role.id}"
  policy = "${data.aws_iam_policy_document.instance_s3_policy.json}"
}

resource "aws_iam_role_policy_attachment" "instance_attach_amazon_ssm_policy" {
  role       = "${aws_iam_role.instance_role.id}"
  policy_arn = "${data.aws_iam_policy.ssm_policy.arn}"
}
