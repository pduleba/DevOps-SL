#!/usr/bin/env bash
mkdir -p out/$2/$1/log
export TF_LOG_PATH=out/$2/$1/log/$3.log
export TF_LOG=DEBUG
