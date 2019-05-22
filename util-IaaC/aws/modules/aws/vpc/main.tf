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

resource "aws_flow_log" "flow_log" {
  vpc_id = "${aws_vpc.vpc.id}"

  log_destination = "${aws_cloudwatch_log_group.log_group.arn}"
  traffic_type    = "ALL"
  iam_role_arn    = "${aws_iam_role.vpc_flowlog_role.arn}"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${
      format(
        "%s/%s",
        "/aws/vpc/flowlogs",
        module.commons.resource_name_prefix
      )
    }"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "log_group"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_iam_role_policy" "vpc_flowlog_role_policy" {
  name = "${
    format(
      "%s_%s",
      module.commons.resource_name_prefix,
      "vpc_flowlog_role_policy"
    )
  }"

  role   = "${aws_iam_role.vpc_flowlog_role.id}"
  policy = "${data.aws_iam_policy_document.vpc_flowlog_policy.json}"
}

resource "aws_iam_role" "vpc_flowlog_role" {
  name = "${
    format(
      "%s_%s",
      module.commons.resource_name_prefix,
      "vpc_flowlog_role"
    )
  }"

  description        = "${format("%s :: %s", module.commons.resource_name_prefix, "Allows VPC to call CloudWatchFlowLogs service on your behalf.")}"
  assume_role_policy = "${data.aws_iam_policy_document.vpc_flowlog_assume_role_policy.json}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "vpc_flowlog_role"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${local.VPC_CIDR}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "vpc"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_subnet" "subnets" {
  # Loop
  count = "${local.SUBNET_COUNT}"

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(local.VPC_CIDR, 4, count.index)}"
  availability_zone       = "${data.aws_availability_zones.available_zones.names[count.index]}"
  map_public_ip_on_launch = "${count.index < local.SUBNET_PUBLIC_COUNT}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s_%s",
        module.commons.resource_name_prefix,
        count.index < local.SUBNET_PUBLIC_COUNT ? "public_subnet" : "private_subnet",
        data.aws_availability_zones.available_zones.names[count.index]
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "igw"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_eip" "ngw_eip" {
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "ngw_eip"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw_eip.id}"

  # Use last public subnet
  subnet_id = "${element(aws_subnet.subnets.*.id, local.SUBNET_PUBLIC_COUNT - 1)}"

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        "ngw"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_route_table" "rts" {
  # Loop (public & private)
  count = 2

  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${count.index < 1 ? aws_internet_gateway.igw.id : aws_nat_gateway.ngw.id}"
  }

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        count.index < 1 ? "public_rt" : "private_rt"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_route_table_association" "rt_associations" {
  # Loop
  count = "${local.SUBNET_COUNT}"

  # route_tables[0].id = public RT + INTERNET GW
  # route_tables[1].id = private RT + NAT GW
  route_table_id = "${element(aws_route_table.rts.*.id, count.index < local.SUBNET_PUBLIC_COUNT ? 0 : 1)}"

  subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
}

resource "aws_network_acl" "nacls" {
  # Loop
  count = 2

  vpc_id = "${aws_vpc.vpc.id}"

  subnet_ids = ["${
    slice(
        aws_subnet.subnets.*.id,
        count.index < 1 ? 0                         : local.SUBNET_PUBLIC_COUNT,
        count.index < 1 ? local.SUBNET_PUBLIC_COUNT : local.SUBNET_COUNT)
  }"]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix,
        count.index < 1 ? "public_acl" : "private_acl"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_security_group" "public" {
  name        = "${format("%s_%s", module.commons.resource_name_prefix, "public_sg")}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${format("%s :: %s", module.commons.resource_name_prefix, "Public network security group")}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = "${local.SG_PUBLIC_INGRESS_CIDRs}"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = "${local.SG_PUBLIC_INGRESS_CIDRs}"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = "${local.SG_PUBLIC_INGRESS_CIDRs}"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = "${local.SG_PUBLIC_INGRESS_CIDRs}"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix, "public_sg"
      )
    ),
    module.commons.tags
  )}"
}

resource "aws_security_group" "private" {
  name        = "${format("%s_%s", module.commons.resource_name_prefix, "private_sg")}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${format("%s :: %s", module.commons.resource_name_prefix, "Private network security group")}"

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = ["${aws_security_group.public.id}"]
  }

  egress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = ["${aws_security_group.public.id}"]
  }

  tags = "${merge(
    map(
      "Name",
      format(
        "%s_%s",
        module.commons.resource_name_prefix, "private_sg"
      )
    ),
    module.commons.tags
  )}"
}
