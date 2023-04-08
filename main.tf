terraform {
  cloud {
    organization = "vluxe"
    workspaces {
      name = "infra"
    }
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    sops = {
      source  = "carlpett/sops"
      version = "~> 0.5"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  # You need to set this as env var.
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  # or login to terraform cloud to get this value
}

data "sops_file" "secrets" {
  source_file = "secrets.sops.yml"
}

resource "digitalocean_ssh_key" "infra_key" {
  name       = "Infra Pub Key"
  public_key = data.sops_file.secrets.data["infra_pub_key"]
}


module "networking" {
  source = "./modules/networking"
}

module "nats_server" {
  source     = "./modules/nats-server"
  count      = 3
  image      = 130324810
  vpc_id     = module.networking.vpc_id
  public_key = digitalocean_ssh_key.infra_key.fingerprint

}

# module "k8s" {
#   source         = "./modules/k8s"
#   cluster_name   = "app-cluster"
#   vpc_id         = module.networking.vpc_id
#   auto_scale     = true
#   min_nodes      = 3
#   max_nodes      = 6
#   node_pool_size = "s-2vcpu-4gb"
#   tags           = ["Terraform", "dev"]
# }
#
# provider "kubernetes" {
#   host                   = module.k8s.host
#   token                  = module.k8s.token
#   cluster_ca_certificate = module.k8s.cluster_ca_certificate
# }

