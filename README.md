# step-terraform

Terraform installer and launcher for wercker.

[![wercker status](https://app.wercker.com/status/bd2d39bbc95b4b12caeb5caa3b495660/m/master "wercker status")](https://app.wercker.com/project/byKey/bd2d39bbc95b4b12caeb5caa3b495660)

# Options

- `command` (optional) Terraform command (can include some arguments) default: `apply`
- `var_file` (optional) A `.tfvars` file
- `remote_config` (optional) `remote config` arguments

`command` and `remote_config` supported multi lines.

# Example

```yaml
build:
    steps:
        - ww24/terraform:
            command: plan
            var_file: variables.tfvars
            remote_config: |
                -backend=gcs \
                -backend-config='bucket=gcs-bucket' \
                -backend-config='path=terraform.tfstate' \
                -backend-config='project=gcp-project' \
                -backend-config='credentials={ \
                  "private_key": "$GCP_PRIVATE_KEY", \
                  "client_email": "$GCP_CLIENT_EMAIL" \
                }'
```

# License

The MIT License (MIT)

# Changelog
Check versions: https://app.wercker.com/api/v3/steps/ww24/terraform

## 0.11.3
- Update terraform 0.11.3

## 0.10.8
- Update terraform 0.10.8

## 0.9.11
- Update terraform 0.9.11

## 0.8.8
- Update terraform 0.8.8 (sync terraform version)

## 0.4.1 (deprecated)
- Update terraform 0.8.2

## 0.3.0 (deprecated)
- First stable release (terraform 0.7.13)
