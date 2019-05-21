@call exec/session/start ^
    init-backend.log
@terraform init ^
    modules/terraform
@terraform apply ^
    -var-file="config/init/global.tfvars" ^
    -state="out/state/init-backend.tfstate" ^
    modules/terraform
@call exec/session/stop