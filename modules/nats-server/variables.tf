# See for region availability: https://docs.digitalocean.com/products/platform/availability-matrix/
variable "region" {
  description = "The region to deploy the nats nodes to."
  type        = string
  default     = "sfo3"
}

variable "image" {
  description = "The image to deploy."
  type        = string
  default     = "ubuntu-22-04-x64"
}


variable "vpc_id" {
  description = "The ID of the VPC to deploy the nats server node cluster into."
  type        = string
  default     = ""
}

variable "public_key" {
  description = "The public key ansible uses to connect and configure the nats server nodes."
  type        = string
  default     = ""
}
