output "kibana_cluster_ip" {
  description = ""
  value = data.kubernetes_service.kibana_data.spec.0.cluster_ip
}

output "elasticsearch_cluster_ip" {
  description = ""
  value = data.kubernetes_service.elasticsearch_data.spec.0.cluster_ip
}