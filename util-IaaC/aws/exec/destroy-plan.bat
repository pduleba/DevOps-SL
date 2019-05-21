@call exec/session/start ^
    destroy-plan.log ^
    stateful
@terraform plan ^
    -var-file="config/modify/global.tfvars" ^
    -var-file="config/modify/%2/%1.tfvars" ^
    -out="out/plan/destroy-plan.tfplan" ^
    -destroy ^
    modules/aws/%1
@call exec/session/stop