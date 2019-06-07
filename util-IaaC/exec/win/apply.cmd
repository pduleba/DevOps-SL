:: Win Script
@cd ./modules/%1
@call ./../../exec/win/utils/session-start %1 %2 apply
@terraform apply ^
    -input=false ^
    -state="out/%2/%1/state.tfstate" ^
    out/%2/%1/apply-plan.tfplan
@call ./../../exec/win/utils/session-stop
@cd ./../..