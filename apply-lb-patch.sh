#!/bin/bash

echo ''
echo ''
echo '#########################################################'
echo '###               SEVERAL CONFIG                      ###'
echo '#########################################################'
echo '### HELM_NAMESPACE must be set before run this script ###'
echo '#########################################################'
echo ''
echo ''


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

  declare -i returnCode=0
  case $module in
    api|engine|opendata|intelligence|log|things|tools|identity|minio)
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

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Declare an array and delete arguments
  declare -a ARGS=()
  declare -i argcounter=0
  for var in "$@"; do
      ((argcounter++))

      # Ignore host and domain arguments
      if (( $argcounter < 3 )); then
          continue
      fi

      ARGS+=($var)
  done

  $HELM_BIN "${ARGS[@]}"
else
  HELM_PLUGIN_DIR=$(find / -name patch-lb-helmplugin.git)
  HELM_BIN=helm
fi

echo "#############################################################################################################"
echo "                                                                                                             "
echo "  |   |  ____|  |       \  |                           _| _)                    |               _)           "
echo "  |   |  __|    |      |\/ |       __|   _ \   __ \   |    |   _  |      __ \   |  |   |   _  |  |  __ \     "
echo "  ___ |  |      |      |   |      (     (   |  |   |  __|  |  (   |      |   |  |  |   |  (   |  |  |   |    "
echo " _|  _| _____| _____| _|  _|     \___| \___/  _|  _| _|   _| \__, |      .__/  _| \__,_| \__, | _| _|  _|    "
echo "                                                             |___/      _|               |___/               "
echo "                                                                                                             "
echo "#############################################################################################################"
echo
echo "Using kubectl to apply path to loadbalancer Deployment to module: "$module
echo
echo "Checking if current chart is deployed..."

declare -i numtries=0
while [ -z $($HELM_BIN list -n $HELM_NAMESPACE | grep $module | awk '{print $1}') ]
do
  echo $module" Chart is NOT already installed!"
  sleep 2
  numtries+=1

  if (( numtries > 3 )); then
     exit 1
  fi
done

kubectl patch deployment loadbalancer --patch "$(cat $HELM_PLUGIN_DIR/patches/$module-patch/nginx-config-volumes.yaml)" --namespace $HELM_NAMESPACE

echo "loadbalancer Deployment succesfully patched"
