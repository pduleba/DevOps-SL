##################################################################################
# OUTPUT
##################################################################################

output "app_bucket_id" {
  value = "${aws_s3_bucket.app_bucket.id}"
}