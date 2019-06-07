:: Win Script
@aws ssm get-parameter ^
    --name "/pduleba/%2/%1" ^
    --with-decryption ^
    | jq -r ".Parameter.Value"
