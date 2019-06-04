##################################################################################
# OUTPUT
##################################################################################

output "target-groups-rds-arn" {
  value = "${element(aws_alb_target_group.alb_target_groups.*.arn, 0)}"
}

output "target-groups-s3-arn" {
  value = "${element(aws_alb_target_group.alb_target_groups.*.arn, 1)}"
}
