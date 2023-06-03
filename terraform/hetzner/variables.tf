variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
}

variable "labels" {
    type = map(string)
    default = {
        "env" = "dev"
    }
}

variable "datacenter" {
    type = string
    default = "fsn1-dc14"
}

variable "server_name" {
    type = string
    default = "dev-server"
}

variable "server_type" {
    type = string
    default = "cx31" # Large for IntelliJ IDEA Remote Development
}

variable "server_image" {
    type = string
    default = "ubuntu-22.04"
}

variable "ssh_pubkey_path" {
    type = string
    default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_privkey_path" {
    type = string
    default = "~/.ssh/id_ed25519"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
}

variable "root_domain" {
  type        = string
  description = "Root domain"
  default     = "tonetag.is"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID"
  default     = "d78598f3e1da5133c88e3bf61b7cca21"
}

variable "server_ip_override" {
  type        = string
  description = "Server IP override"
  default     = ""
}
