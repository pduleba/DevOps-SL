##################################################################################
# OUTPUT
##################################################################################

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnets_public_ids" {
  value = "${slice(aws_subnet.subnets.*.id, 0, local.SUBNET_PUBLIC_COUNT)}"
}

output "subnets_private_ids" {
  value = "${slice(aws_subnet.subnets.*.id, local.SUBNET_PUBLIC_COUNT, local.SUBNET_COUNT)}"
}

output "security_group_public_id" {
  value = "${aws_security_group.public.id}"
}

output "security_group_private_id" {
  value = "${aws_security_group.private.id}"
}
