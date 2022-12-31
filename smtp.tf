# Create Vault service
resource "docker_container" "smtp" {

  count = local.smtp_enabled ? 1 : 0

  name = "smtp"

  image = docker_image.smtp.image_id

  env = [
    "RELAY_HOST=${var.smtp_creds.host}",
    "RELAY_PORT=${var.smtp_creds.port}",
    "RELAY_USERNAME=${var.smtp_creds.username}",
    "RELAY_PASSWORD=${var.smtp_creds.password}",
  ]

  restart = "always"

  networks_advanced {
    name = docker_network.plausible_private.id
  }
}
