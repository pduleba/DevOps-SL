@cd ..
@set TF_LOG_PATH=./out/log/plan.log
@set TF_LOG=DEBUG
@terraform fmt > ./out/log/fmt.log
terraform plan -var-file="./../terraform.tfvars" -state="./out/state/terraform.tfstate" -out="./out/plan/plan-apply.tfplan"
@cd utils