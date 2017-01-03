#!/bin/bash

trim() {
  # shellcheck disable=SC2001
  echo "$1" | sed -e "s/\\\n\$//"
}

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=${WERCKER_TERRAFORM_VAR_FILE}"
fi

terraform_cli="${WERCKER_STEP_ROOT}/terraform"
$terraform_cli --version

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  echo "terraform remote config"

  # initialize remote config
  rm -rf .terraform

  WERCKER_TERRAFORM_REMOTE_CONFIG=$(trim "${WERCKER_TERRAFORM_REMOTE_CONFIG//'\\n'/' '}")
  remote_config="${WERCKER_STEP_ROOT}/remote_config.sh"
  echo "$terraform_cli remote config \\" > "$remote_config"
  echo "${WERCKER_TERRAFORM_REMOTE_CONFIG}" >> "$remote_config"
  if ! sh "$remote_config"; then
    fail "Invalid remote_config option"
  fi
fi

echo "terraform ${WERCKER_TERRAFORM_COMMAND} $cli_args"
if ! eval "$terraform_cli ${WERCKER_TERRAFORM_COMMAND} $cli_args"; then
  fail "Invalid command option"
fi
