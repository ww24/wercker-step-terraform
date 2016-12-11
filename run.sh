#!/bin/sh

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=variables.tfvars${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  eval "$terraform_cli" "remote config" "${WERCKER_TERRAFORM_REMOTE_CONFIG}"
fi

eval "$terraform_cli" "${WERCKER_TERRAFORM_COMMAND}" "$cli_args"
