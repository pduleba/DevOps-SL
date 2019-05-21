@call exec/session/start ^
    init.log
@terraform init ^
    -backend-config="config/init/global.tfvars" ^
    -backend-config="config/init/%2/%1.tfvars" ^
    modules/aws/%1
@call exec/session/stop
