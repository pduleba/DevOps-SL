##################################################################################
# OUTPUT
##################################################################################

output "dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "target_group_rds_arn" {
  value = "${
    length(aws_alb_target_group.alb_target_groups) > 0 ?
    element(aws_alb_target_group.alb_target_groups.*.arn, 0) :
    null
  }"
}

output "target_group_s3_arn" {
  value = "${
    length(aws_alb_target_group.alb_target_groups) > 1 ?
    element(aws_alb_target_group.alb_target_groups.*.arn, 1) :
    null
  }"
}
