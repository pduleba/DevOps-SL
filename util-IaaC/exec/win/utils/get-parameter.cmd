@aws ssm get-parameter ^
    --name "/pduleba-app/%2/%1" ^
    --with-decryption ^
    --profile pduleba-admin-cli-profile | jq -r ".Parameter.Value"