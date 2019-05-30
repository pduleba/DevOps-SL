@call exec/session/start ^
    output.log ^
    stateful ^
    quiet
@terraform output ^
    %1
@call exec/session/stop ^
    quiet