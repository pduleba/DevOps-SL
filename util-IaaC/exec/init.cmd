@call exec/session/start ^
    init-%1.log
:: https://www.terraform.io/docs/backends/config.html
@terraform init ^
    -backend-config="config/global.tfvars" ^
    -backend-config="key=%2/%1.tfstate" ^
    modules/%1
@call exec/session/stop
