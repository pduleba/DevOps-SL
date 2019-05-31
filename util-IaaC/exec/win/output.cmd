@call exec/win/session/start ^
    output.log ^
    stateful ^
    quiet
@terraform output ^
    %1
@call exec/win/session/stop ^
    quiet