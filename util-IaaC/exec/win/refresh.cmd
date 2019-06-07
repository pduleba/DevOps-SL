:: Win Script
@call exec/win/utils/session-start ^
    refresh-%1.log ^
    stateful
@terraform refresh ^
    -var-file="config/global.tfvars" ^
    -var-file="config/env/%2/%1.tfvars" ^
    modules/%1
@call ./../../exec/win/utils/session-stop
@cd ./../..