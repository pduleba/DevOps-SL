:: Win Script
@cd ./modules/%1
@call ./../../exec/win/utils/session-start %1 %2 init
@set options=
@if "%1" NEQ "backend" (
    set options=-backend-config="./../../config/global.tfvars" -backend-config="key=%2/%1.tfstate"
)
:: https://www.terraform.io/docs/backends/config.html
@terraform init ^
    %options% ^
    .
@call ./../../exec/win/utils/session-stop
@cd ./../..