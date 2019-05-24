@call exec/session/start ^
    destroy-plan-%1.log ^
    stateful
@terraform plan ^
    -var-file="config/modify/global.tfvars" ^
    -var-file="config/modify/%2/%1.tfvars" ^
    -out="out/plan/destroy-plan-%1.tfplan" ^
    -destroy ^
    modules/aws/%1
@call exec/session/stop