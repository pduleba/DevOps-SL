#!/usr/bin/env bash
aws s3 cp \
    ./target/$1 \
    $2