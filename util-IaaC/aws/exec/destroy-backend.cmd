@call exec/session/start ^
    destroy-backend.log
    stateful
@terraform init ^
    modules/backend
@terraform destroy ^
    -var-file="config/init/global.tfvars" ^
    -state="out/state/backend.tfstate" ^
    modules/backend
@call exec/session/stop