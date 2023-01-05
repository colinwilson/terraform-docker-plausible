resource "docker_container" "clickhouse" {
  name = var.clickhouse_container_name

  image = docker_image.clickhouse.image_id

  env = [
    "CLICKHOUSE_DB=${var.clickhouse_db_name}",
    "CLICKHOUSE_USER=default"
  ]

  restart = "always"

  upload {
    source      = "${path.module}/config/clickhouse/clickhouse-config.xml"
    source_hash = filesha256("${path.module}/config/clickhouse/clickhouse-config.xml")
    file        = "/etc/clickhouse-server/config.d/reduce_logging.xml"
  }
  upload {
    source      = "${path.module}/config/clickhouse/clickhouse-users-config.xml"
    source_hash = filesha256("${path.module}/config/clickhouse/clickhouse-users-config.xml")
    file        = "/etc/clickhouse-server/users.d/disable_query_logging.xml"
  }

  mounts {
    source    = docker_volume.plausible_event_data.name
    target    = "/var/lib/clickhouse"
    type      = "volume"
    read_only = false
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
