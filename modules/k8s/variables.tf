variable "cluster_name" {
  description = "Name of the managed k8 cluster. Must be unique."
  type = string
}

// See for region availability: https://docs.digitalocean.com/products/platform/availability-matrix/
variable "region" {
  description = "The region to deploy managed k8 cluster to."
  type = string
  default = "sf03"
}

// Use `doctl kubernetes options versions` to see available versions
variable "image_version" {
  description = "Set the version of k8 to deploy."
  type = string
  default = "1.20.2-do.0"
}

variable "node_pool_name" {
  description = "Name of the managed k8 cluster node pool. Must be unique."
  type = string
  default = "autoscale-worker-pool"
}

variable "node_pool_size" {
  description = "Set the slug of what droplet/VM size is use within the cluster."
  type = string
  default = "s-2vcpu-2gb"
}

variable "auto_scale" {
  description = "Set if the cluster will use the auto scaler. Will scale between the min and max number of nodes set."
  type = bool
  default = false
}

variable "min_nodes" {
  description = "Set the min number of nodes that can exist in the node pool of the cluster. Need at least 3 for HA."
  type = number
  default = 1
}

variable "max_nodes" {
    description = "Set the max number of nodes that can exist in the mode pool of the cluster."
    type = number
    default = 5
}

variable "tags" {
  description = "Set the node pool tags. Useful for distinguishing between environments"
  type = list(string)
  default = []
}