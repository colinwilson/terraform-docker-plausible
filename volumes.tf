resource "docker_volume" "plausible_db_data" {
  count = var.ext_postgres_creds.enabled != true ? 1 : 0
  name  = "plausible_db_data"
}

resource "docker_volume" "plausible_event_data" {
  name = "plausible_event_data"
}

resource "docker_volume" "plausible_geoip" {
  name = "plausible_geoip"
}