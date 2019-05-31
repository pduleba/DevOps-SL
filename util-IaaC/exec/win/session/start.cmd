@if not exist out mkdir out\log out\plan out\state
@if "%2" EQU "stateful" (
    @if "%3" NEQ "quiet" (
	    @echo WARNING :: Preserving current state of .terraform
    )
) ELSE (
    @rm -rf .terraform
)
@set TF_LOG_PATH=out/log/%1
@set TF_LOG=DEBUG