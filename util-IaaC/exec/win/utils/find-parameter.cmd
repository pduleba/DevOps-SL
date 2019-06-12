:: Win Script
@jq -r ".[] | select(.Name|endswith(\"%1\")) | .Value"