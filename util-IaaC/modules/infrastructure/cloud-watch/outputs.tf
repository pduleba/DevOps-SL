##################################################################################
# OUTPUT
##################################################################################

output "alarm_names" {
  value = "${aws_cloudwatch_metric_alarm.alarms.*.alarm_name}"
}