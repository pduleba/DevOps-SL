#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/ux/utils/session-start.sh $1 $2 init
options=
if [[ "$1" != "backend" ]] ; then
    options=-backend-config="./../../config/global.tfvars"\ -backend-config="key=$2/$1.tfstate"
fi
# https://www.terraform.io/docs/backends/config.html
terraform init \
    $options \
    .
. ./../../exec/ux/utils/session-stop.sh
cd ./../..