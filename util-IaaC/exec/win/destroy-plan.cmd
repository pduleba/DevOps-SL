@call exec/win/session/start ^
    destroy-plan-%1.log ^
    stateful
@set options=
@if "%1" EQU "backend" (
    set options=-state="out/state/backend.tfstate"
)
@terraform fmt ^
    modules/%1 > out/log/fmt-%1.log
@terraform plan ^
    -var-file="config/global.tfvars" ^
    -var-file="config/env/%2/%1.tfvars" ^
    -out="out/plan/destroy-plan-%1.tfplan" ^
    %options% ^
    -destroy ^
    modules/%1
@call exec/win/session/stop