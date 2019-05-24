##################################################################################
# OUTPUT
##################################################################################

output "vpc_bucket" {
  value = "${element(
    aws_s3_bucket.buckets.*.bucket,
    local.VPC_BUCKET_INDEX
  )}"
}

output "alb_bucket" {
  value = "${element(
    aws_s3_bucket.buckets.*.bucket,
    local.ALB_BUCKET_INDEX
  )}"
}

output "app_bucket" {
  value = "${element(
    aws_s3_bucket.buckets.*.bucket,
    local.APP_BUCKET_INDEX
  )}"
}
