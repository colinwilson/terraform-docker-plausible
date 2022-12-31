resource "docker_network" "plausible_private" {
  name            = "plausible_private"
  driver          = "overlay"
  attachable      = true
  check_duplicate = true
}

data "docker_network" "additional_networks" {
  for_each = var.networks
  name     = each.key
}