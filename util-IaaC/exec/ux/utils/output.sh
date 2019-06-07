#!/usr/bin/env bash
cd ./modules/$1
. ./../../exec/ux/utils/session-start.sh $1 output output
terraform output \
    $1
. ./../../exec/ux/utils/session-stop.sh
cd ./../..