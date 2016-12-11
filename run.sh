#!/bin/sh

rmlf() {
  # https://github.com/koalaman/shellcheck/wiki/Ignore
  # shellcheck disable=SC2005
  # shellcheck disable=SC2046
  # shellcheck disable=SC2116
  echo $(echo "$1")
}

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  WERCKER_TERRAFORM_REMOTE_CONFIG=$(rmlf "${WERCKER_TERRAFORM_REMOTE_CONFIG}")
  $terraform_cli remote config "${WERCKER_TERRAFORM_REMOTE_CONFIG}"
fi

WERCKER_TERRAFORM_COMMAND=$(rmlf "${WERCKER_TERRAFORM_COMMAND}")
$terraform_cli "${WERCKER_TERRAFORM_COMMAND} $cli_args"
