output "vpc_id" {
  description = "The ID of the app network VPC."
  value       = digitalocean_vpc.app_vpc.id
}
