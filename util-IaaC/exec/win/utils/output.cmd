:: Win Script
@cd ./modules/%1
@call ./../../exec/win/utils/session-start %1 output output
@terraform output ^
    %1
@call ./../../exec/win/utils/session-stop
@cd ./../..