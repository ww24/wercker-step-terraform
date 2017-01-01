#!/bin/bash

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  # initialize remote config
  rm -rf .terraform

  cat "$terraform_cli remote config" > /tmp/remote_config
  cat "$WERCKER_TERRAFORM_REMOTE_CONFIG" >> /tmp/remote_config
  chmod +x /tmp/remote_config
  if ! sh /tmp/remote_config; then
    fail "Invalid remote_config option"
  fi
fi

WERCKER_TERRAFORM_COMMAND=${WERCKER_TERRAFORM_COMMAND//'\n'/' '}
if ! eval "$terraform_cli ${WERCKER_TERRAFORM_COMMAND} $cli_args"; then
  fail "Invalid command option"
fi
