##################################################################################
# VARIABLES
##################################################################################

variable "owner" {}

variable "name_prefix" {}
variable "name_delimiter" {default = "-"}
variable "name_postfix" {}

# By default use resource related parameters if not provided
variable "tag_name_prefix" {default = ""}
variable "tag_name_delimiter" {default = ""}
variable "tag_name_postfix" {default = ""}

variable "description" {default = ""}

variable "path" {default = ""}

##################################################################################
# LOCALS
##################################################################################

locals {
  NAME = "${format(
    "%s%s%s",
    var.name_prefix,
    var.name_delimiter,
    var.name_postfix
  )}"
  BASE_TAGS = "${map(
      "Owner", var.owner
    )
  }"
  TAGS = "${merge(
    map(
      "Name", format(
        "%s%s%s",
        coalesce(var.tag_name_prefix, var.name_prefix),
        coalesce(var.tag_name_delimiter, var.name_delimiter),
        coalesce(var.tag_name_postfix, var.name_postfix)
      )
    ),
    local.BASE_TAGS
  )}"
}

##################################################################################
# OUTPUTS
##################################################################################

output "name" {
  value = "${local.NAME}"
}

output "description" {
  value = "${var.description}"
}

output "base_tags" {
  value = "${local.BASE_TAGS}"
}

output "path" {
  value = "${var.path}"
}

output "tags" {
  value = "${local.TAGS}"
}
