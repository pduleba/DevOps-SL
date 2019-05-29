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

data "aws_security_group" "rds" {
  tags = "${module.rds-sg.tags}"
}

