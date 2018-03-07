# step-terraform

Terraform installer and launcher for wercker.

[![wercker status](https://app.wercker.com/status/bd2d39bbc95b4b12caeb5caa3b495660/m/master "wercker status")](https://app.wercker.com/project/byKey/bd2d39bbc95b4b12caeb5caa3b495660)

# Options

- `command` (optional) Terraform command (can include some arguments) default: `apply`
- `var_file` (optional) A `.tfvars` file
- `backend_config` (optional) A backend config file

# Example

```yaml
build:
    steps:
        - ww24/terraform@0.11.3:
            command: plan
            var_file: variables.tfvars
            backend_config: backend.config
```

# License

The MIT License (MIT)

# Changelog
Check versions: https://app.wercker.com/api/v3/steps/ww24/terraform

## 0.11.3
- Update terraform 0.11.3

## 0.10.9
- Fix backend config for terraform 0.10.9

## 0.10.8 (deprecated)
- Update terraform 0.10.8

## 0.9.12
- Fix backend config for terraform 0.9.11

## 0.9.11 (deprecated)
- Update terraform 0.9.11

## 0.8.8
- Update terraform 0.8.8 (sync terraform version)
