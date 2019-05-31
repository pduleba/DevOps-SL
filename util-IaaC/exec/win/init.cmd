@call exec/win/session/start ^
    init-%1.log
@set options=
@if "%1" NEQ "backend" (
    set options=-backend-config="config/global.tfvars" -backend-config="key=%2/%1.tfstate"
)
:: https://www.terraform.io/docs/backends/config.html
@terraform init ^
    %options% ^
    modules/%1
@call exec/win/session/stop
