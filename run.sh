#!/bin/bash

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  WERCKER_TERRAFORM_REMOTE_CONFIG=${WERCKER_TERRAFORM_REMOTE_CONFIG//'\n'/' '}
  eval "$terraform_cli remote config ${WERCKER_TERRAFORM_REMOTE_CONFIG}"
  if [ "$?" -gt 0 ]; then
    fail "Invalid remote_config option"
  fi
fi

WERCKER_TERRAFORM_COMMAND=${WERCKER_TERRAFORM_COMMAND//'\n'/' '}
eval "$terraform_cli ${WERCKER_TERRAFORM_COMMAND} $cli_args"
if [ "$?" -gt 0 ]; then
  fail "Invalid command option"
fi
