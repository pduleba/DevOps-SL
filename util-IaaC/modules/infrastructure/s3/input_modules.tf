##################################################################################
# MODULES
##################################################################################

module "app-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}"
}

module "ssm-parameter-app-bucket" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "/${var.resource_name_prefix}"
  name_delimiter = "/"
  name_postfix  = "${var.ssm_parameter_environment_postfix}/${var.ssm_parameter_app_bucket_key_postfix}"

  tag_name_prefix = "${var.resource_name_prefix}"
  tag_name_delimiter = "-"
  tag_name_postfix = "ssm-parameter-app-bucket"

  description  = "DevOps upskill AWS RDS app bucket name parameter"
}
