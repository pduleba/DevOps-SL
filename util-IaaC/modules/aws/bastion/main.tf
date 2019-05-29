##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "bastion" {
  # AMI
  ami = "${var.instance_ami}"

  # Instance type
  instance_type = "${var.instance_type}"

  # Configure instance
  subnet_id                   = "${element(data.aws_subnet.public.*.id, 0)}"
  associate_public_ip_address = true
  placement_group             = null // no placement group by default
  credit_specification {
    cpu_credits = "standard"
  }
  iam_instance_profile                 = "${aws_iam_instance_profile.bastion_instance_profile.name}"
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination              = false
  monitoring                           = false
  tenancy                              = "default"
  source_dest_check                    = true
  user_data                            = "${data.template_file.bastion_script.rendered}"

  # Storage
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  # Security groups
  vpc_security_group_ids = "${list(data.aws_security_group.bastion.id)}"

  # Review
  key_name = "${var.instance_key_pair_name}"

  # Tags
  volume_tags = "${module.bastion-ebs.tags}"
  tags        = "${module.bastion.tags}"
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "${module.bastion-instance-profile.name}"
  role = "${aws_iam_role.bastion_role.name}"
}

resource "aws_iam_role" "bastion_role" {
  name = "${module.bastion-role.name}"

  description        = "${module.bastion-role.description}"
  assume_role_policy = "${data.aws_iam_policy_document.bastion_assume_role_policy.json}"

  tags = "${module.bastion-role.tags}"
}

resource "aws_iam_role_policy" "bastion_s3_inline_policy" {
  name = "${module.bastion-s3-inline-policy.name}"


  role   = "${aws_iam_role.bastion_role.id}"
  policy = "${data.aws_iam_policy_document.bastion_s3_policy.json}"
}

resource "aws_iam_role_policy_attachment" "bastion_attach_amazon_ssm_policy" {
  role       = "${aws_iam_role.bastion_role.id}"
  policy_arn = "${data.aws_iam_policy.ssm_policy.arn}"
}
