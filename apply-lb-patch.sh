#!/bin/bash

# if an error occurs the script stops inmediately
set -e

parseParams() {

  if [[ ${#params[@]} -lt 2 ]]; then
    echo "Bad params number!"
    help
    exit 1
  fi

  if [[ ${params[0]} != '--module' ]]; then
    echo "Bad parameter! --module"
    help
    exit 1
  fi

  module=${params[1]}

  returnCode=0
  case $module in
    api|engine|opendata|intelligence|log|things|tools)
      echo "Right module"
      returnCode=0
      ;;
    *)
      echo "Wrong module..."
      returnCode=1
      ;;
  esac

  if [[ $returnCode == 1 ]]; then
    exit 1
  fi
}

params=("$@")

parseParams

echo "Using kubectl to apply path to loadbalancer Deployment to module: "$module

kubectl patch deployment loadbalancer --patch "$(cat $HELM_PLUGIN_DIR/patches/$module-patch/nginx-config-volumes.yaml)" --namespace $HELM_NAMESPACE

echo "loadbalancer Deployment succesfully patched"

# Declare an array and delete arguments
declare -a ARGS=()
declare -i argcounter=0
for var in "$@"; do
    ((argcounter++))

    # Ignore host and domain arguments
    if (( $argcounter < 5 )); then
        continue
    fi

    ARGS+=($var)
done

$HELM_BIN "${ARGS[@]}"
