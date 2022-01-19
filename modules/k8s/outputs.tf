output "host" {
  description = ""
  value = data.digitalocean_kubernetes_cluster.cluster_data.endpoint
}

output "token" {
  description = ""
  value = data.digitalocean_kubernetes_cluster.cluster_data.kube_config[0].token
}

output "cluster_ca_certificate" {
  description = ""
  value = base64decode(data.digitalocean_kubernetes_cluster.cluster_data.kube_config[0].cluster_ca_certificate)
}