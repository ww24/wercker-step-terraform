#!/bin/bash

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  # initialize remote config
  rm -rf .terraform

  remote_config="${WERCKER_STEP_ROOT}/remote_config"
  echo "$terraform_cli remote config \\" > "$remote_config"
  echo "${WERCKER_TERRAFORM_REMOTE_CONFIG//'\\n'/' '}" >> "$remote_config"
  chmod +x "$remote_config"
  if ! sh "$remote_config"; then
    fail "Invalid remote_config option"
  fi
fi

WERCKER_TERRAFORM_COMMAND=${WERCKER_TERRAFORM_COMMAND//'\n'/' '}
if ! eval "$terraform_cli ${WERCKER_TERRAFORM_COMMAND} $cli_args"; then
  fail "Invalid command option"
fi
