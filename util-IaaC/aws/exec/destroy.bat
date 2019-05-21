@call exec/session/start ^
    destroy.log ^
    stateful
@terraform fmt ^
    modules/aws/%1 > out/log/fmt.log
@terraform destroy ^
    -var-file="config/modify/global.tfvars" ^
    -var-file="config/modify/%2/%1.tfvars" ^
    modules/aws/%1
@call exec/session/stop