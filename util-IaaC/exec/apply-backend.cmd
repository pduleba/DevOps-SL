@call exec/session/start ^
    apply-backend.log ^
    stateful
@terraform init ^
    modules/backend
@terraform apply ^
    -var-file="config/global.tfvars" ^
    -var-file="config/backend/global.tfvars" ^
    -state="out/state/backend.tfstate" ^
    modules/backend
@call exec/session/stop