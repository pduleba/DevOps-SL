@call exec/session/start ^
    apply-plan-%1.log ^
    stateful
@terraform plan ^
    -var-file="config/modify/global.tfvars" ^
    -var-file="config/modify/%2/%1.tfvars" ^
    -out="out/plan/apply-plan-%1.tfplan" ^
    modules/aws/%1
@call exec/session/stop