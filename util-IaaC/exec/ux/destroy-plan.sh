#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/ux/utils/session-start.sh $1 $2 destroy-plan
terraform fmt . > out/$2/$1/log/fmt.log
terraform plan \
    -input=false \
    -state="out/$2/$1/state.tfstate" \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    -out="out/$2/$1/destroy-plan.tfplan" \
    -destroy \
    .
. ./../../exec/ux/utils/session-stop.sh
cd ./../..