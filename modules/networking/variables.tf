variable "name" {
  description = "Name of the VPC. Must be unique."
  type        = string
  default     = "app-vpc"
}

# See for region availability: https://docs.digitalocean.com/products/platform/availability-matrix/
variable "region" {
  description = "The region of the VPC."
  type        = string
  default     = "sfo3"
}
