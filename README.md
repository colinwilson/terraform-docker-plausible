# Terraform Docker Plausible Module
A Terraform module to provision the self-hosted version of [Plausible Analytics](https://plausible.io) on a Docker Swarm cluster with the Traefik ingress controller. A great way to quickly deploy Plausible for development/testing or 'low traffic' sites.

![Plausible Analytics Dashboard](https://res.cloudinary.com/lotuslabs/image/upload/v1673015990/Lotus%20Docs/Social%20Media/plausible-analytics-screenshot_ds_rdd_c6bi3o.webp)

## Compatibility/Requirements

* Requires [Terraform](https://www.terraform.io/downloads.html) 1.2.0 or higher.
* Traefik ingress controller, see: [colinwilson/terraform-docker-traefik-v2](https://github.com/colinwilson/terraform-docker-traefik-v2) (or any other ingress controller e.g. nginx)

## Usage
Basic usage of this module is as follows:
```
module "plausible_docker" {
  source = "github.com/colinwilson/terraform-docker-plausible"

  hostname           = "plausible.example.com"
  base_url           = "https://plausible.example.com"
  networks           = ["traefik"] # name of your Traefik Network
}
```
Example output:
```
connected_networks = [
  "traefik",
]
options_status = {
  "external_pg_enabled" = false
  "maxmind_enabled" = false
  "smtp_enabled" = false
}
```

Setup DNS records pointing your domain to your ingress and navigate to your `hostname` e.g. https://plausible.example.com

You'll be presented with a registration page to create the admin/owner account.

![Plausible Analytics Registration Page](https://res.cloudinary.com/lotuslabs/image/upload/v1672923448/Lotus%20Docs/Social%20Media/plausible-analytics-registration-page_bairzy.webp)

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | Plausible base URL | `string` | `"http://localhost"` | no |
| <a name="input_clickhouse_container_name"></a> [clickhouse\_container\_name](#input\_clickhouse\_container\_name) | ClickHouse Container name. | `string` | `"plausible_event_db"` | no |
| <a name="input_clickhouse_db_name"></a> [clickhouse\_db\_name](#input\_clickhouse\_db\_name) | ClickHouse Database name. | `string` | `"plausible"` | no |
| <a name="input_clickhouse_version"></a> [clickhouse\_version](#input\_clickhouse\_version) | ClickHouse image version. | `string` | `"22.6-alpine"` | no |
| <a name="input_disable_registration"></a> [disable\_registration](#input\_disable\_registration) | Disables registration of new users. Valid options are true, false & invite\_only | `string` | `"invite_only"` | no |
| <a name="input_ext_postgres_creds"></a> [ext\_postgres\_creds](#input\_ext\_postgres\_creds) | Postgres database credentials. | <pre>object({<br>    enabled = optional(bool, false)<br>    config = optional(object({<br>      username = optional(string)<br>      password = optional(string)<br>      host     = optional(string)<br>      port     = optional(number, 5432)<br>      db_name  = optional(string)<br>      ssl      = optional(bool, false)<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_geoip_creds"></a> [geoip\_creds](#input\_geoip\_creds) | MaxMind credentials. | <pre>object({<br>    acc = string<br>    key = string<br>  })</pre> | <pre>{<br>  "acc": null,<br>  "key": null<br>}</pre> | no |
| <a name="input_geoip_db"></a> [geoip\_db](#input\_geoip\_db) | Set which MaxMind Database Plausible will utilise? | `string` | `"GeoLite2-City"` | no |
| <a name="input_geoip_version"></a> [geoip\_version](#input\_geoip\_version) | MaxMind GeoIP Update Tool image version. | `string` | `"v4.10"` | no |
| <a name="input_hcaptcha_creds"></a> [hcaptcha\_creds](#input\_hcaptcha\_creds) | hCaptcha credentials. | <pre>object({<br>    sitekey = string<br>    secret  = string<br>  })</pre> | <pre>{<br>  "secret": null,<br>  "sitekey": null<br>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Plausible hostname | `string` | `"localhost"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level | `string` | `"warn"` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Set of existing networks to connect Plausible to. | `set(string)` | `[]` | no |
| <a name="input_plausible_version"></a> [plausible\_version](#input\_plausible\_version) | Plausible Analytics image version. | `string` | `"v1.5.1"` | no |
| <a name="input_postgres_container_name"></a> [postgres\_container\_name](#input\_postgres\_container\_name) | Postgres container name | `string` | `"plausible_db"` | no |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | PostgreSQL image version. | `string` | `"14-alpine"` | no |
| <a name="input_reduce_event_logging"></a> [reduce\_event\_logging](#input\_reduce\_event\_logging) | Reduce the level of query logging in ClickHouse? | `bool` | `true` | no |
| <a name="input_smtp_creds"></a> [smtp\_creds](#input\_smtp\_creds) | SMTP Credentials | <pre>object({<br>    mailname = string<br>    host     = string<br>    port     = number<br>    username = string<br>    password = string<br>  })</pre> | <pre>{<br>  "host": null,<br>  "mailname": null,<br>  "password": null,<br>  "port": null,<br>  "username": null<br>}</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_connected_networks"></a> [connected\_networks](#output\_connected\_networks) | List of existing networks the Plausible service is connected to. |
| <a name="output_options_status"></a> [options\_status](#output\_options\_status) | Brief summary of which options are enabled? |
<!-- END_TF_DOCS -->