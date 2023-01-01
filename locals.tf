locals {

  external_pg_enabled = var.ext_postgres_creds.enabled != true ? false : true

  pg_username = var.ext_postgres_creds.config.username == null ? "postgres" : var.ext_postgres_creds.config.username
  pg_password = var.ext_postgres_creds.config.password == null ? "postgres" : var.ext_postgres_creds.config.password
  pg_host     = var.ext_postgres_creds.config.host == null ? "postgres" : var.ext_postgres_creds.config.host
  pg_port     = var.ext_postgres_creds.config.port == null ? 5432 : var.ext_postgres_creds.config.port
  pg_db_name  = var.ext_postgres_creds.config.db_name == null ? "plausible_event_db" : var.ext_postgres_creds.config.db_name
  pg_ssl      = var.ext_postgres_creds.config.ssl == null ? false : var.ext_postgres_creds.config.ssl

  ext_postgres_uri = "postgres://${local.pg_username}:${urlencode(local.pg_password)}@${local.pg_host}:${local.pg_port}/${local.pg_db_name}?ssl=${local.pg_ssl}"

  entrypoint = var.ext_postgres_creds.enabled != true ? "/entrypoint.sh db createdb && /entrypoint.sh db migrate && /entrypoint.sh run" : "/entrypoint.sh db migrate && /entrypoint.sh run"

  maxmind_enabled  = try(coalesce(values(var.geoip_creds)...), null) != null ? true : false
  smtp_enabled     = try(coalesce(values(var.smtp_creds)...), null) != null ? true : false
  hcaptcha_enabled = try(coalesce(values(var.hcaptcha_creds)...), null) != null ? true : false
}