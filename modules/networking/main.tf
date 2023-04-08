terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_vpc" "app_vpc" {
  name     = var.name
  region   = var.region
  ip_range = "10.10.10.0/24"
}
