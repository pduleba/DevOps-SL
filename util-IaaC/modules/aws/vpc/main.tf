##################################################################################
# RESOURCES
##################################################################################

resource "aws_iam_role_policy" "flowlog_cloudwatch_role_policy" {
  name = "${module.flowlog-cloudwatch-role-policy.name}"

  role   = "${aws_iam_role.flowlog_cloudwatch_role.id}"
  policy = "${data.aws_iam_policy_document.flowlog_policy.json}"
}

resource "aws_iam_role" "flowlog_cloudwatch_role" {
  name = "${module.flowlog-cloudwatch-role.name}"

  description        = "${module.flowlog-cloudwatch-role.description}"
  assume_role_policy = "${data.aws_iam_policy_document.flowlog_assume_role_policy_document.json}"

  tags = "${module.flowlog-cloudwatch-role.tags}"
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "${module.cloudwatch-log-group.name}"

  tags = "${module.cloudwatch-log-group.tags}"
}

resource "aws_flow_log" "cloudwatch_flowlog" {
  vpc_id = "${aws_vpc.vpc.id}"

  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = "${aws_cloudwatch_log_group.cloudwatch_log_group.arn}"
  iam_role_arn         = "${aws_iam_role.flowlog_cloudwatch_role.arn}"
}

resource "aws_flow_log" "s3_flowlog" {
  vpc_id = "${aws_vpc.vpc.id}"

  traffic_type         = "ALL"
  log_destination_type = "s3"
  log_destination      = "${aws_s3_bucket.vpc_flowlog_bucket.arn}"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${local.VPC_CIDR}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = "${module.vpc.tags}"
}

resource "aws_subnet" "subnets" {
  # Loop
  count = "${local.SUBNET_COUNT}"

  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(local.VPC_CIDR, 4, count.index)}"
  availability_zone       = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = "${count.index < local.SUBNET_PUBLIC_COUNT}"

  tags = "${count.index < local.SUBNET_PUBLIC_COUNT ? module.public-subnet.tags : module.private-subnet.tags}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${module.igw.tags}"
}

resource "aws_eip" "ngw_eip" {
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = "${module.ngw-eip.tags}"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw_eip.id}"

  # Use last public subnet
  subnet_id = "${element(aws_subnet.subnets.*.id, local.SUBNET_PUBLIC_COUNT - 1)}"

  tags = "${module.ngw.tags}"
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = "${module.public-rt.tags}"
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags = "${module.private-rt.tags}"
}

resource "aws_route_table_association" "rt_associations" {
  # Loop
  count = "${local.SUBNET_COUNT}"

  # route_tables[0].id = public RT + INTERNET GW
  # route_tables[1].id = private RT + NAT GW
  route_table_id = "${count.index < local.SUBNET_PUBLIC_COUNT ? aws_route_table.public_rt.id : aws_route_table.private_rt.id}"

  subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
}

resource "aws_network_acl" "nacls" {
  # Loop
  count = 2

  vpc_id = "${aws_vpc.vpc.id}"

  subnet_ids = "${
    slice(
      aws_subnet.subnets.*.id,
      count.index % 2 < 1 ? 0 : local.SUBNET_PUBLIC_COUNT,
      count.index % 2 < 1 ? local.SUBNET_PUBLIC_COUNT : local.SUBNET_COUNT
    )
  }"

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

  tags = "${count.index % 2 < 1 ? module.public-acl.tags : module.private-acl.tags}"
}

resource "aws_security_group" "alb_sg" {
  name        = "${module.alb-sg.name}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${module.alb-sg.description}"

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

  tags = "${module.alb-sg.tags}"
}

resource "aws_security_group" "bastion_sg" {
  name        = "${module.bastion-sg.name}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${module.bastion-sg.description}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = "${local.SG_PUBLIC_INGRESS_CIDRs}"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${module.bastion-sg.tags}"
}

resource "aws_security_group" "ec2_sg" {
  name        = "${module.ec2-sg.name}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${module.ec2-sg.description}"

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = "${list(aws_security_group.alb_sg.id, aws_security_group.bastion_sg.id)}"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${module.ec2-sg.tags}"
}

resource "aws_security_group" "rds_sg" {
  name        = "${module.rds-sg.name}"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${module.rds-sg.description}"

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = "${list(aws_security_group.ec2_sg.id, aws_security_group.bastion_sg.id)}"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${module.rds-sg.tags}"
}

resource "aws_s3_bucket" "vpc_flowlog_bucket" {

  bucket = "${module.vpc-flowlog-bucket.name}"

  acl           = "private"
  force_destroy = "true"

  tags = "${module.vpc-flowlog-bucket.tags}"
}
