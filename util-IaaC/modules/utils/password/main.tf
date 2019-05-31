##################################################################################
# VARIABLES
##################################################################################

variable "length" {}
variable "special_character_set" {default = "!"}

##################################################################################
# LOCALS
##################################################################################

locals {
  PASSWORD = "${random_string.master_password.result}"
}

##################################################################################
# RESOURCES
##################################################################################

resource "random_string" "master_password" {
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html
  length           = "${var.length}"
  upper            = true
  min_upper        = 1
  lower            = true
  min_lower        = 1
  number           = true
  min_numeric      = 1
  special          = true
  min_special      = 1
  override_special = "${var.special_character_set}"
}

##################################################################################
# OUTPUTS
##################################################################################

output "password" {
  value = "${local.PASSWORD}"
}
