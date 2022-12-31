# Create Vault service
resource "docker_container" "geoip" {

  count = local.maxmind_enabled ? 1 : 0

  name = "geoip"

  image = docker_image.geoip.image_id

  env = [
    "GEOIPUPDATE_ACCOUNT_ID=${var.geoip_creds.acc}",
    "GEOIPUPDATE_LICENSE_KEY=${var.geoip_creds.key}",
    "GEOIPUPDATE_EDITION_IDS=GeoLite2-City GeoLite2-Country GeoLite2-ASN",
    "GEOIPUPDATE_FREQUENCY=168" # update every 7 days
  ]

  restart = "always"

  mounts {
    source    = docker_volume.plausible_geoip.name
    target    = "/usr/share/GeoIP"
    type      = "volume"
    read_only = false
  }

  networks_advanced {
    name = docker_network.plausible_private.id
  }
}
