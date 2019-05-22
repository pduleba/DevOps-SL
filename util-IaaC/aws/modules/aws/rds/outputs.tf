##################################################################################
# OUTPUT
##################################################################################

output "vpc_id" {
  value = "${data.aws_vpc.vpc.id}"
}

output "subnets_public_ids" {
  value = "${data.aws_subnet.subnets_public.*.id}"
}

output "subnets_private_ids" {
  value = "${data.aws_subnet.subnets_private.*.id}"
}

output "security_group_public_id" {
  value = "${data.aws_security_group.security_group_public.id}"
}

output "security_group_private_id" {
  value = "${data.aws_security_group.security_group_private.id}"
}

output "tags" {
  value = "${module.commons.tags}"
}
