#!/bin/sh

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  WERCKER_TERRAFORM_REMOTE_CONFIG=$(echo "${WERCKER_TERRAFORM_REMOTE_CONFIG}" | sed -e 's/\\n/ /g')
  $terraform_cli remote config "${WERCKER_TERRAFORM_REMOTE_CONFIG}"
fi

WERCKER_TERRAFORM_COMMAND=$(echo "${WERCKER_TERRAFORM_COMMAND}" | sed -e 's/\\n/ /g')
$terraform_cli "${WERCKER_TERRAFORM_COMMAND} $cli_args"
