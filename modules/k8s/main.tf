terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Create a k8 cluster
resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.image_version

  node_pool {
    name       = var.node_pool_name
    size       = var.node_pool_size
    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
    tags = var.tags
  }
}

# get the data to export for use in other modules (like deploying the operators)
data "digitalocean_kubernetes_cluster" "cluster_data" {
  name = var.cluster_name
  depends_on = [digitalocean_kubernetes_cluster.cluster]
}
