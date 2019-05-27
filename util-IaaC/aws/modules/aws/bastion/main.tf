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

resource "aws_instance" "bastion" {
  # AMI
  ami = "${var.instance_ami}"

  # Instance type
  instance_type = "${var.instance_type}"

  # Configure Instance
  subnet_id                   = "${data.aws_subnet.public.id}"
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
  user_data                            = "${data.template_file.bastion_init_script.rendered}"

  # Storage
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  # Security groups
  vpc_security_group_ids = "${list(data.aws_security_group.security_group_public_bastion.id)}"

  # Review
  key_name = "${var.key_pair_name}"

  # Tags
  volume_tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "bastion_ebs"
      )
    ),
    module.commons.tags
  )}"
  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "bastion"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "${format(
    "%s_%s",
    module.commons.resource_name_prefix,
    "bastion_instance_profile"
  )}"
  role = "${aws_iam_role.bastion_role.name}"
}

resource "aws_iam_role" "bastion_role" {
  name = "${format(
    "%s_%s",
    module.commons.resource_name_prefix,
    "bastion_role"
  )}"

  description = "${format(
    "%s :: %s",
    module.commons.resource_name_prefix,
    "DevOps upskill role allowing EC2 Bastion to access infrastructure private resources on your behalf."
  )}"
  assume_role_policy = "${data.aws_iam_policy_document.bastion_assume_role_policy.json}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "bastion_role"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_iam_role_policy" "bastion_s3_inline_policy" {
  name = "${format(
    "%s_%s",
    module.commons.resource_name_prefix,
    "bastion_s3_inline_policy"
  )}"


  role   = "${aws_iam_role.bastion_role.id}"
  policy = "${data.aws_iam_policy_document.bastion_s3_policy.json}"
}

resource "aws_iam_role_policy_attachment" "bastion_attach_amazon_ssm_policy" {
  role       = "${aws_iam_role.bastion_role.id}"
  policy_arn = "${data.aws_iam_policy.bastion_ssm_policy.arn}"
}
