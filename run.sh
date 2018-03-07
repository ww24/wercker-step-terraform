#!/bin/bash -x

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

if [ -n "${WERCKER_TERRAFORM_BACKEND_CONFIG}" ]; then
  echo "terraform init"
  # initialize backend config
  rm -rf .terraform
  $terraform_cli init --backend-config="${WERCKER_TERRAFORM_BACKEND_CONFIG}"
fi

echo "terraform ${WERCKER_TERRAFORM_COMMAND} $cli_args"
if ! eval "$terraform_cli ${WERCKER_TERRAFORM_COMMAND} $cli_args"; then
  fail "Invalid command option"
fi
