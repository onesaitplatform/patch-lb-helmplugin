# !/bin/bash

# if an error occurs the script stops inmediately
set -e

kubectl patch deployment loadbalancer --patch "$(cat patches/$1-patch/nginx-config-volumes.yaml)" --namespace $HELM_NAMESPACE

$HELM_BIN "${ARGS[@]}"
