@call exec/session/start ^
    destroy-backend.log ^
    stateful
@terraform init ^
    modules/backend
@terraform destroy ^
    -var-file="config/global.tfvars" ^
    -var-file="config/backend/global.tfvars" ^
    -state="out/state/backend.tfstate" ^
    modules/backend
@call exec/session/stop