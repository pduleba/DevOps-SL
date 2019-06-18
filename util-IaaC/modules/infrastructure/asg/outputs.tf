##################################################################################
# OUTPUT
##################################################################################

output "autoscaling_group_rds_name" {
  value = "${
    length(aws_autoscaling_group.autoscaling_groups) > 0 ?
    element(aws_autoscaling_group.autoscaling_groups.*.name, 0) :
    null
  }"
}

output "autoscaling_group_s3_name" {
  value = "${
    length(aws_autoscaling_group.autoscaling_groups) > 1 ?
    element(aws_autoscaling_group.autoscaling_groups.*.name, 1) :
    null
  }"
}
