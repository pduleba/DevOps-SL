##################################################################################
# TERRAFORM
##################################################################################

terraform {
  # values injected by `name` from file specied on `init` via `-backend-config` parameter
  # not in use by 'plan'/'apply'/'destroy' once initialized
  # for locking use 'lock_table' of AWS DynamoDB - see https://www.terraform.io/docs/backends/types/s3.html#lock_table
  backend "s3" {}
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_s3_bucket" "buckets" {

  bucket = "${element(
    local.BUCKETS,
    count.index
  )}"

  acl           = "private"
  force_destroy = "true"

  // TODO add CORS rule for app-bucket

  tags = "${merge(
    map(
      "Name",
      element(
        local.BUCKETS,
        count.index
      )
    ),
    module.commons.tags
  )}"
}
