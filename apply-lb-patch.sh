# !/bin/bash

# if an error occurs the script stops inmediately
set -e

params=("$@")

echo "Using kubectl to apply path to loadbalancer Deployment"

kubectl patch deployment loadbalancer --patch "$(cat patches/'${params[0]'-patch/nginx-config-volumes.yaml)" --namespace $HELM_NAMESPACE

echo "loadbalancer Deployment succesfully patched"

$HELM_BIN "${ARGS[@]}"
