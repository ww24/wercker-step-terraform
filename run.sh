#!/bin/sh

if [ -z "${WERCKER_TERRAFORM_VERSION}" ]; then
  fail "Please provide a Terraform version"
fi

cli_args=

if [ -n "${WERCKER_TERRAFORM_VAR_FILE}" ]; then
  cli_args="$cli_args -var-file=variables.tfvars${WERCKER_TERRAFORM_VAR_FILE}"
fi

# install terraform cli
terraform_cli=/tmp/terraform
mkdir -p $terraform_cli
cd $terraform_cli

curl -sLO "https://releases.hashicorp.com/terraform/${WERCKER_TERRAFORM_VERSION}/terraform_${WERCKER_TERRAFORM_VERSION}_linux_amd64.zip"
unzip "terraform_${WERCKER_TERRAFORM_VERSION}_linux_amd64.zip"
rm "terraform_${WERCKER_TERRAFORM_VERSION}_linux_amd64.zip"

cd "${WERCKER_SOURCE_DIR}"

# run terraform cli
terraform_cli=$terraform_cli/terraform

if [ -n "${WERCKER_TERRAFORM_REMOTE_CONFIG}" ]; then
  eval "$terraform_cli" "remote config" "${WERCKER_TERRAFORM_REMOTE_CONFIG}"
fi

eval "$terraform_cli" "${WERCKER_TERRAFORM_COMMAND}" "$cli_args"
