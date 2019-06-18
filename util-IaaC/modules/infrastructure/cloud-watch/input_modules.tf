##################################################################################
# MODULES
##################################################################################

module "alarm-rds" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-rds"
  description  = "DevOps upskill CloudWatch allarm monitoring EC2 application RDS domain."
}

module "alarm-s3" {
  source = "../../utils/resource"

  owner        = "${var.owner}"
  name_prefix  = "${var.resource_name_prefix}"
  name_postfix = "${var.resource_name_postfix}-s3"
  description  = "DevOps upskill CloudWatch allarm monitoring EC2 application S3 domain."
}
