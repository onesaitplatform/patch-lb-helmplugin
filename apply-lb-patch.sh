#!/bin/bash

# if an error occurs the script stops inmediately
set -e

parseParams() {

  if [[ ${#params[@]} -lt 1 ]]; then
    echo "Bad params number!"
    help
    exit 1
  fi

  if [[ ${params[0]} != '--module' ]]; then
    echo "Bad parameter! --module"
    help
    exit 1
  fi

  module=${params[0]}

}

params=("$@")

parseParams

echo "Using kubectl to apply path to loadbalancer Deployment to module: "$module

kubectl patch deployment loadbalancer --patch "$(cat patches/$module-patch/nginx-config-volumes.yaml)" --namespace $HELM_NAMESPACE

echo "loadbalancer Deployment succesfully patched"

$HELM_BIN "${ARGS[@]}"
