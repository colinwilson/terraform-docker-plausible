resource "docker_image" "postgres" {
  count        = var.ext_postgres_creds.enabled != true ? 1 : 0
  name         = "postgres:${var.postgres_version}"
  keep_locally = true
}

resource "docker_image" "clickhouse" {
  name         = "clickhouse/clickhouse-server:${var.clickhouse_version}"
  keep_locally = true
}

resource "docker_image" "smtp" {
  name         = "bytemark/smtp:latest"
  keep_locally = true
}

resource "docker_image" "geoip" {
  name         = "maxmindinc/geoipupdate:${var.geoip_version}"
  keep_locally = true
}

resource "docker_image" "plausible" {
  name         = "plausible/analytics:${var.plausible_version}"
  keep_locally = true
}