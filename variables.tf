variable "hostname" {
  type        = string
  description = "Plausible hostname"
  default     = "localhost"
}

variable "base_url" {
  type        = string
  description = "Plausible base URL"
  default     = "http://localhost"
}

variable "disable_registration" {
  type        = string
  description = "Disables registration of new users. Valid options are true, false & invite_only"
  default     = "invite_only"
}

variable "ext_postgres_creds" {
  description = "Postgres database credentials."
  type = object({
    enabled = optional(bool, false)
    config = optional(object({
      username = optional(string)
      password = optional(string)
      host     = optional(string)
      port     = optional(number, 5432)
      db_name  = optional(string)
      ssl      = optional(bool, false)
    }), {})
  })
  default = {}
}

variable "geoip_db" {
  type        = string
  description = "Set which MaxMind Database Plausible will utilise?"
  default     = "GeoLite2-City"
}

variable "geoip_creds" {
  description = "MaxMind credentials."
  type = object({
    acc = string
    key = string
  })
  default = {
    acc = null
    key = null
  }
  sensitive = true
}

variable "hcaptcha_creds" {
  description = "hCaptcha credentials."
  type = object({
    sitekey = string
    secret  = string
  })
  default = {
    sitekey = null
    secret  = null
  }
  sensitive = true
}

variable "smtp_creds" {
  description = "SMTP Credentials"
  type = object({
    mailname = string
    host     = string
    port     = number
    username = string
    password = string
  })
  default = {
    mailname = null
    host     = null
    password = null
    port     = null
    username = null
  }
}

variable "networks" {
  type        = set(string)
  description = "Set of existing networks to connect Plausible to."
  default     = []
}

variable "plausible_version" {
  type        = string
  description = "Plausible Analytics image version."
  default     = "v1.5.1"
}

variable "clickhouse_version" {
  type        = string
  description = "ClickHouse image version."
  default     = "22.6-alpine"
}

variable "postgres_version" {
  type        = string
  description = "PostgreSQL image version."
  default     = "14-alpine"
}

variable "geoip_version" {
  type        = string
  description = "MaxMind GeoIP Update Tool image version."
  default     = "v4.10"
}

variable "clickhouse_container_name" {
  type        = string
  description = "ClickHouse Container name."
  default     = "plausible_event_db"
}

variable "clickhouse_db_name" {
  type        = string
  description = "ClickHouse Database name."
  default     = "plausible"
}

variable "postgres_container_name" {
  type        = string
  description = "Postgres container name"
  default     = "plausible_db"
}

variable "log_level" {
  type        = string
  description = "Log level"
  default     = "warn"
}