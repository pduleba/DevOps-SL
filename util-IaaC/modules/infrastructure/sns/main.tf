##################################################################################
# RESOURCES
##################################################################################


resource "aws_sns_topic" "topic" {
  name = "${module.topic.name}"

  display_name = "${module.topic.name}"
  delivery_policy = "${data.template_file.delivery_policy.rendered}"

  tags = "${module.topic.tags}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.topic.arn}"
  policy = "${data.aws_iam_policy_document.topic_policy_document.json}"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = "${aws_sns_topic.topic.arn}"

  endpoint = "${var.sns_endpoint}"
  protocol = "${var.sns_protocol}"

  endpoint_auto_confirms = "${var.endpoint_auto_confirms}"
  confirmation_timeout_in_minutes = "${var.confirmation_timeout_in_minutes}"
  raw_message_delivery = "${var.raw_message_delivery}"

}