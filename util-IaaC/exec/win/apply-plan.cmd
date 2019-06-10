:: Win Script
@cd ./modules/%1
@call ./../../exec/win/utils/session-start %1 %2 apply-plan
@terraform fmt . > out/%2/%1/log/fmt.log
@terraform plan ^
    -input=false ^
    -state="out/%2/%1/state.tfstate" ^
    -var-file="./../../config/global.tfvars" ^
    -var-file="./../../config/env/%2/%1.tfvars" ^
    -out="out/%2/%1/apply-plan.tfplan" ^
    .
@call ./../../exec/win/utils/session-stop
@cd ./../..