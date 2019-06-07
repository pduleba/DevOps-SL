#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/ux/utils/session-start.sh $1 output apply
terraform apply \
    -input=false \
    -state="out/$2/$1/state.tfstate" \
    out/$2/$1/apply-plan.tfplan
. ./../../exec/ux/utils/session-stop.sh
cd ./../..