##################################################################################
# VARIABLES
##################################################################################

variable "tags" {
  description = "A map of common tags to add to all resources"
  type        = "map"

  default = {
    Owner = "pduleba"
  }
}

variable "resource_name_prefix" {
  description = ""
  type = "string"

  default = "pduleba-app"
}

##################################################################################
# OUTPUTS
##################################################################################

output "tags" {
  value = "${var.tags}"
}

output "resource_name_prefix" {
  value = "${var.resource_name_prefix}"
}