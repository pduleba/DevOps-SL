#!/usr/bin/env bash
jq -r ".[] | select(.Name|endswith(\"$1\")) | .Value"