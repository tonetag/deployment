locals {
  generic_subdomains = [
    {
      name            = "dev"
      value           = hcloud_server.main.ipv4_address
      type            = "A"
      ttl             = 1
      proxied         = false
      allow_overwrite = true
    },
    {
      name            = var.root_domain
      value           = coalesce(var.server_ip_override, hcloud_server.main.ipv4_address)
      type            = "A"
      ttl             = 1
      proxied         = false
      allow_overwrite = true
    }
  ]
}

resource "cloudflare_record" "sites" {
  for_each = {
    for site in local.generic_subdomains : site.name => site
  }
  zone_id         = var.cloudflare_zone_id
  name            = each.value.name
  value           = each.value.value
  type            = each.value.type
  ttl             = each.value.ttl
  proxied         = each.value.proxied
  allow_overwrite = each.value.allow_overwrite
}
