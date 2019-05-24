@call exec/session/start ^
    apply-backend.log
    stateful
@terraform init ^
    modules/backend
@terraform apply ^
    -var-file="config/init/global.tfvars" ^
    -state="out/state/backend.tfstate" ^
    modules/backend
@call exec/session/stop