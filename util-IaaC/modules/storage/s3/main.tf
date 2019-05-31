##################################################################################
# RESOURCES
##################################################################################

resource "aws_s3_bucket" "app_bucket" {

  bucket = "${module.app-bucket.name}"

  acl           = "private"
  force_destroy = "true"

  // TODO :: Add CORS rule for app-bucket

  tags = "${module.app-bucket.tags}"
}

resource "aws_s3_bucket" "access_log_s3_bucket" {
  bucket = "${module.alb-access-log-bucket.name}"

  acl           = "private"
  force_destroy = "true"
  policy        = "${data.aws_iam_policy_document.access_log_s3_bucket_policy_document.json}"

  tags = "${module.alb-access-log-bucket.tags}"
}

resource "aws_ssm_parameter" "app_bucket" {
  name  = "${module.ssm-parameter-app-bucket.name}"

  description = "${module.ssm-parameter-app-bucket.description}"
  value = "${aws_s3_bucket.app_bucket.bucket}"
  type  = "SecureString"
  overwrite = true

  tags = "${module.ssm-parameter-app-bucket.tags}"
}
