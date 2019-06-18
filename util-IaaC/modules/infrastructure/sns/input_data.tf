##################################################################################
# DATA
##################################################################################

data "template_file" "delivery_policy" {
  template = "${file(var.sns_delivery_policy_template_path)}"
}

data "aws_iam_policy_document" "topic_policy_document" {

  policy_id = "__default_policy_ID"

  statement {
    effect = "Allow"

    actions = [
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:Receive",
      "SNS:AddPermission",
      "SNS:Subscribe"
    ]

    resources = [
      "${aws_sns_topic.topic.arn}"
    ]

    principals {
      type = "AWS"
      identifiers = ["*"]
    }

    condition {
      test = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        // Owner can publish and subscribe to the topic only
        "${var.sns_policy_source_owner_account_id}"
      ]
    }

    sid = "__default_statement_ID"
  }
}