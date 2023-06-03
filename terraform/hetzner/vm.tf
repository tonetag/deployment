resource "hcloud_primary_ip" "main" {
  name          = "ip_${var.server_name}}"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = var.labels
}
resource "hcloud_primary_ip" "secondary" {
  name          = "ip_${var.server_name}_2"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = var.labels
}

resource "hcloud_ssh_key" "ssh_key_test" {
  name       = "SSH Key for ${var.server_name}"
  public_key = file("${var.ssh_pubkey_path}")
}

resource "hcloud_server" "main" {
  name        = var.server_name
  server_type = var.server_type
  image       = var.server_image
  datacenter  = var.datacenter
  labels = var.labels
  public_net {
    ipv4_enabled = true
    ipv4 = hcloud_primary_ip.main.id
    ipv6_enabled = false
  }

  ssh_keys = [
    hcloud_ssh_key.ssh_key_test.id
  ]

  provisioner "remote-exec" {
    inline = ["apt update", "apt install -y python3"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_privkey_path)
    }
  }

}

resource "ansible_host" "default" {
  depends_on = [ hcloud_primary_ip.main ]
  name   = var.server_name

  variables = {
    ansible_host             = hcloud_server.main.ipv4_address
    ansible_user             = "root"
    ansible_ssh_private_key_file = var.ssh_privkey_path
  }
}
