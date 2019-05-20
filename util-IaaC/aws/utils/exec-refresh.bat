@cd ..
@set TF_LOG_PATH=./out/log/refresh.log
@set TF_LOG=DEBUG
@terraform fmt > ./out/log/fmt.log
terraform refresh -var-file="./../terraform.tfvars" -state="./out/state/terraform.tfstate"
@cd utils