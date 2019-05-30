@call exec/session/start ^
    destroy-%1.log ^
    stateful
@terraform fmt ^
    modules/aws/%1 > out/log/fmt.log
@terraform destroy ^
    -var-file="config/global.tfvars" ^
    -var-file="config/env/%2/%1.tfvars" ^
    modules/aws/%1
@call exec/session/stop