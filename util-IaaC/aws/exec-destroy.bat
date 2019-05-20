@set TF_LOG_PATH=./out/log/destroy.log
@set TF_LOG=DEBUG
@terraform fmt > ./out/log/fmt.log
terraform destroy -var-file="./../terraform.tfvars" -state="./out/state/terraform.tfstate"