terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
  required_version = ">= 1.2.0"
}

provider "docker" {
  # If connecting to a remote host from a local machine running Terraform, ensure your ~/.ssh/config specifies the correct host/key for authentication
  # See - https://github.com/terraform-providers/terraform-provider-docker/issues/268
  host = var.docker_host_url
}

module "plausible_docker" {
  source = "github.com/colinwilson/terraform-docker-plausible"
}