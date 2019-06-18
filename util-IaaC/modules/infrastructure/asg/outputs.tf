##################################################################################
# OUTPUT
##################################################################################

output "autoscaling_group_rds_id" {
  value = "${
    length(aws_autoscaling_group.autoscaling_groups) > 0 ?
    element(aws_autoscaling_group.autoscaling_groups.*.id, 0) :
    null
  }"
}

output "autoscaling_group_s3_id" {
  value = "${
    length(aws_autoscaling_group.autoscaling_groups) > 1 ?
    element(aws_autoscaling_group.autoscaling_groups.*.id, 1) :
    null
  }"
}
