:: Win Script
@cd ./modules/%1
@call ./../../exec/win/utils/session-start %1 %2 destroy
@terraform destroy ^
    -auto-approve ^
    -input=false ^
    -state="out/%2/%1/state.tfstate" ^
    -var-file="./../../config/global.tfvars" ^
    -var-file="./../../config/env/%2/%1.tfvars" ^
    .
@call ./../../exec/win/utils/session-stop
@cd ./../..