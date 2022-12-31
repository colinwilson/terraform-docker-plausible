# Default Example

This example demonstrates how to use the `terraform-docker-plausible` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| docker_host_url | URL to connect to your Docker Swarm host. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| options_status | Brief summary of which options are enabled? |
| connected_networks | List of existing networks the Plausible service is connected to. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, replace the values in the `variables.tf` file with your own and run the following commands from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure