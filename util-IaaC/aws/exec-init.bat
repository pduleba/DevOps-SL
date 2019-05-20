@if not exist out\log mkdir out\log
@if not exist out\state mkdir out\state
@if not exist out\plan mkdir out\plan
@set TF_LOG_PATH=./out/log/init.log
@set TF_LOG=DEBUG
@terraform fmt > ./out/log/fmt.log
terraform init