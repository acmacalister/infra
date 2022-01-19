terraform {
  cloud {
    organization = "vluxe"
    workspaces {
      name = "infra"
    }
  }

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  # or login to terraform cloud to get this value
}

module "k8s" {
  source = "./modules/k8s"

  cluster_name = "app_cluster"
  auto_scale = true
  min_nodes = 1
  max_nodes = 3
  tags = ["Terraform", "dev"]
}

provider "kubernetes" {
  host             = module.k8s.host
  token            = module.k8s.token
  cluster_ca_certificate = module.k8s.cluster_ca_certificate
}

# module "elasticsearch" {
#   source = "./modules/elasticsearch"
#   depends_on = [module.k8s]
# }