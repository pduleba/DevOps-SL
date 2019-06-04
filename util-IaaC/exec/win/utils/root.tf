# This is needed by `terraform output` as workarround https://github.com/hashicorp/terraform/issues/15761#issuecomment-321094947
terraform {
  backend "s3" {}
}