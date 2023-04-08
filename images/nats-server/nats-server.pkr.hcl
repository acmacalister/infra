packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.1.1"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

# https://developer.hashicorp.com/packer/plugins/builders/digitalocean#required
source "digitalocean" "nats-server" {
  image        = "ubuntu-22-04-x64"
  region       = "sfo3"
  size         = "s-1vcpu-512mb-10gb"
  ssh_username = "root"
}

build {
  sources = [
    "source.digitalocean.nats-server"
  ]

  provisioner "ansible" {
    use_proxy = false
    playbook_file = "../../config-management/packer-nats-server.yml"
  }
}

