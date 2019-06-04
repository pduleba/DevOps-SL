@call exec/win/utils/session-start ^
    output.log ^
    stateful ^
    quiet
@cp ^
    exec/win/utils/root.tf ^
    .
@terraform output ^
    %1
@rm ^
    root.tf
@call exec/win/utils/session-stop ^
    quiet