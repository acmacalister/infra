
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.2"
    }
  }
}

resource "random_id" "server" {
  byte_length = 4
}

locals {
  server_name = "nats-server-${random_id.server.hex}"
}


resource "digitalocean_droplet" "nats_server" {
  name     = local.server_name
  size     = "s-1vcpu-1gb"
  image    = var.image
  region   = var.region
  vpc_uuid = var.vpc_id
  ssh_keys = [var.public_key]
  tags     = ["nats-servers"]

}

