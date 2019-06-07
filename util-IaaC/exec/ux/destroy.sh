#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/ux/utils/session-start.sh $1 $2 destroy
terraform destroy \
    -auto-approve \
    -input=false \
    -state="out/$2/$1/state.tfstate" \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    .
. ./../../exec/ux/utils/session-stop.sh
cd ./../..