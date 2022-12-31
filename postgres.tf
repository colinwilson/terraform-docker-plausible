# Create Vault service
resource "docker_container" "postgres" {
  count = var.ext_postgres_creds.enabled != true ? 1 : 0

  name = var.postgres_container_name

  image = docker_image.postgres[0].name

  env = [
    "POSTGRES_PASSWORD=postgres"
  ]

  restart = "always"

  mounts {
    source    = docker_volume.plausible_db_data[0].name
    target    = "/var/lib/postgresql/data"
    type      = "volume"
    read_only = false
  }

  networks_advanced {
    name = docker_network.plausible_private.id
  }
}
