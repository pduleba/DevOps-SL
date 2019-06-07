#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/win/utils/session-start.sh $1 $2 refresh
terraform refresh \
    -input=false \
    -state="out/$2/$1/state.tfstate" \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    .
. ./../../exec/win/utils/session-stop.sh
cd ./../..