##################################################################################
# MODULES
##################################################################################

module "application" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-application"
}

module "deployment-group" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-deployment-group"
}

module "deployment-config" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-deployment-config"
}

module "code-deploy-role" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-role"
  description  = "DevOps upskill role allowing CodeDeploy to access infrastructure private resources on your behalf."
}
