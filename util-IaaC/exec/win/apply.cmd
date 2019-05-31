@call exec/win/session/start ^
    apply-%1.log ^
    stateful
@set options=
@if "%1" EQU "backend" (
    set options=-state="out/state/backend.tfstate"
)
@terraform apply ^
    -var-file="config/global.tfvars" ^
    -var-file="config/env/%2/%1.tfvars" ^
    %options% ^
    modules/%1
@call exec/win/session/stop