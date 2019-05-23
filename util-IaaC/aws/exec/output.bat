@call exec/session/start ^
    output.log ^
    stateful ^
    quiet
@cp ^
    exec/utils/root.tf ^
    .
@terraform output ^
    %1
@rm ^
    root.tf
@call exec/session/stop ^
    quiet