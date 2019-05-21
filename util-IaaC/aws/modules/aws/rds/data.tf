##################################################################################
# DATA
##################################################################################

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    profile = "${var.profile}"

    region  = "${var.region}"
    bucket  = "${var.bucket}"
    key     = "${var.key_vpc_state}"
  }
}
