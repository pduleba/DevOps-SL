##################################################################################
# LOCALS
##################################################################################

locals {
  # https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
  BUCKETS = [
    // vpc bucket
    "${format(
      "%s-%s",
      module.commons.resource_name_prefix,
      var.vpc_bucket_postfix
    )}",
    // alb bucket
    "${format(
      "%s-%s",
      module.commons.resource_name_prefix,
      var.alb_bucket_postfix
    )}",
    // app bucket
    "${format(
      "%s-%s",
      module.commons.resource_name_prefix,
      var.app_bucket_postfix
    )}"
  ]
  VPC_BUCKET_INDEX = 0
  ALB_BUCKET_INDEX = 1
  APP_BUCKET_INDEX = 2
}