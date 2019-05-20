@set TF_LOG_PATH=./out/log/apply.log
@set TF_LOG=DEBUG
@terraform fmt > ./out/log/fmt.log
terraform apply -var-file="./../terraform.tfvars" -state="./out/state/terraform.tfstate"