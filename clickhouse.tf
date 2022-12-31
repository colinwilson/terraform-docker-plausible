# Create Vault service
resource "docker_container" "clickhouse" {
  name = var.clickhouse_container_name

  image = docker_image.clickhouse.image_id

  env = [
    "CLICKHOUSE_DB=${var.clickhouse_db_name}",
    "CLICKHOUSE_USER=default"
  ]

  restart = "always"

  mounts {
    source    = docker_volume.plausible_event_data.name
    target    = "/var/lib/clickhouse"
    type      = "volume"
    read_only = false
  }

  mounts {
    source    = "/var/log"
    target    = "/etc/clickhouse-server/config.d/logging.xml"
    type      = "bind"
    read_only = true
  }

  mounts {
    source    = "/var/log"
    target    = "/etc/clickhouse-server/users.d/logging.xml"
    type      = "bind"
    read_only = true
  }

  ulimit {
    name = "nofile"
    hard = 262144
    soft = 262144
  }

  networks_advanced {
    name = docker_network.plausible_private.id
  }
}
