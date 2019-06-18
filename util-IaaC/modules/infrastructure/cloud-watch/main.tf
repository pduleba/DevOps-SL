##################################################################################
# RESOURCES
##################################################################################

resource "aws_cloudwatch_metric_alarm" "alarms" {
  # Loop
  count = 2

  alarm_name = "${
    count.index % 2 < 1 ?
    module.alarm-rds.name :
    module.alarm-s3.name
  }"

  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"
  datapoints_to_alarm = "${var.datapoints_to_alarm}"
  unit                = "${var.unit}"
  treat_missing_data  = "${var.treat_missing_data}"

  alarm_description = "${
    count.index % 2 < 1 ?
    module.alarm-rds.description :
    module.alarm-s3.description
  }"

  dimensions = {
    AutoScalingGroupName = "${
      count.index % 2 < 1 ?
      data.aws_autoscaling_group.rds.name :
      data.aws_autoscaling_group.s3.name
    }"
  }

  actions_enabled     = "${var.actions_enabled}"
  insufficient_data_actions = "${list(data.aws_sns_topic.topic.arn)}"
  alarm_actions = "${list(data.aws_sns_topic.topic.arn)}"

  tags = "${
    count.index % 2 < 1 ?
    module.alarm-rds.tags :
    module.alarm-s3.tags
  }"
}