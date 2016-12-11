# step-terraform

Terraform installer and launcher for wercker.

[![wercker status](https://app.wercker.com/status/df76928d3517477b1bfc1557ae764114/s/master "wercker status")](https://app.wercker.com/project/bykey/df76928d3517477b1bfc1557ae764114)

# Options

version:
    type: string
    required: true
command:
    type: string
    required: false
    default: apply
var_file:
    type: string
    required: false
remote_config:
    type: string
    required: false

- `version` Terraform version
- `command` (optional) Terraform command (can include some arguments) default: `apply`
- `var_file` (optional) A `.tfvars` file
- `remote_config` (optional) `remote config` arguments

# Example

```yaml
build:
    steps:
        - ww24/terraform:
            version: 0.7.13
            command: plan
            var_file: variables.tfvars
            remote_config: |
                -backend=gcs \
                -backend-config="bucket=gcs-bucket" \
                -backend-config="path=terraform.tfstate" \
                -backend-config="project=gcp-project" \
                -backend-config="credentials=$(cat account.json)
```

Terraform cli run in `$WERCKER_SOURCE_DIR`

# License

The MIT License (MIT)
