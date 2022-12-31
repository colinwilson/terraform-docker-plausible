output "options_status" {
  description = "Brief summary of which options are enabled?"
  value = {
    external_pg_enabled : local.external_pg_enabled
    maxmind_enabled : local.maxmind_enabled
    smtp_enabled : local.smtp_enabled
  }
}

output "connected_networks" {
  description = "List of existing networks the Plausible service is connected to."
  value       = values(data.docker_network.additional_networks).*.name
}