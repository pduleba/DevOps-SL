##################################################################################
# MODULES
##################################################################################

module "app-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.app_bucket_postfix}"
}

module "alb-access-log-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.access_log_bucket_name_postfix}"
}
