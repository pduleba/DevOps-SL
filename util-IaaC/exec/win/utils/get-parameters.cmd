:: Win Script
@aws ssm get-parameters-by-path ^
    --path "/pduleba/%1" ^
    --recursive ^
    --with-decryption ^
    --query "Parameters[*].{Name:Name,Value:Value}"