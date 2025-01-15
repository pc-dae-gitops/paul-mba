#!/usr/bin/env bash

# Utility for creating secrets in Vault
# Version: 1.0
# Author: Paul Carlton (mailto:paul.carlton@dae.mn)

set -euo pipefail

function usage()
{
    echo "usage ${0} [--debug] --secrets <secrets file>" >&2
    echo "This script will create secrets in Vault" >&2
}

function args() {
  tls_skip=""
  script_tls_skip=""
  aws_dir="${HOME}/.aws"
  aws_credentials="${aws_dir}/credentials"

  arg_list=( "$@" )
  arg_count=${#arg_list[@]}
  arg_index=0
  debug_str=""
  while (( arg_index < arg_count )); do
    case "${arg_list[${arg_index}]}" in
          "--secrets") (( arg_index+=1 ));secrets_file=${arg_list[${arg_index}]};;
          "--debug") set -x; debug_str="--debug";;
               "-h") usage; exit;;
           "--help") usage; exit;;
               "-?") usage; exit;;
        *) if [ "${arg_list[${arg_index}]:0:2}" == "--" ];then
               echo "invalid argument: ${arg_list[${arg_index}]}" >&2
               usage; exit
           fi;
           break;;
    esac
    (( arg_index+=1 ))
  done
}

args "$@"

source ${secrets_file}

vault kv put -mount=secrets infra-couchdb type=$TYPE provider=$PROVIDER host=$HOST port=$PORT url=$PROVIDER://$HOST:$PORT/$DATABASE database=$DATABASE username=$USERNAME password=$PASSWORD
