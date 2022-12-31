# Create Vault service
resource "docker_service" "plausible" {
  name = "plausible"

  task_spec {
    container_spec {

      image = docker_image.plausible.image_id

      command = [
        "sh",
        "-c",
        local.entrypoint
      ]

      env = {
        BASE_URL                = var.base_url
        DISABLE_REGISTRATION    = var.disable_registration
        SECRET_KEY_BASE         = random_password.secret_key_base.result
        DATABASE_URL            = var.ext_postgres_creds.enabled != true ? "postgres://postgres:postgres@${docker_container.postgres[0].name}:5432/plausible_db" : local.ext_postgres_uri
        CLICKHOUSE_DATABASE_URL = "http://${docker_container.clickhouse.name}:8123/${var.clickhouse_db_name}"
        GEOLITE2_COUNTRY_DB     = local.maxmind_enabled ? "/geoip/${var.geoip_db}.mmdb" : null
        MAILER_EMAIL            = local.smtp_enabled ? "${var.smtp_creds.mailname}" : null
        SMTP_HOST_ADDR          = local.smtp_enabled ? docker_container.smtp[0].name : null
      }

      labels {
        label = "traefik.enable"
        value = true
      }

      labels {
        label = "traefik.http.routers.plausible.rule"
        value = "Host(`${var.hostname}`)"
      }

      labels {
        label = "traefik.http.routers.plausible.entrypoints"
        value = "https"
      }

      labels {
        label = "traefik.http.services.plausible.loadbalancer.server.port"
        value = "8000"
      }

      labels {
        label = "traefik.http.routers.plausible.tls.certresolver"
        value = "cloudflare"
      }

      dynamic "mounts" {

        for_each = local.maxmind_enabled ? [1] : []

        content {
          source    = docker_volume.plausible_geoip.name
          target    = "/geoip"
          type      = "volume"
          read_only = true
        }
      }
    }
    networks = concat(values(data.docker_network.additional_networks).*.id, [docker_network.plausible_private.id])
  }

  depends_on = [
    docker_container.geoip[0]
  ]
}
