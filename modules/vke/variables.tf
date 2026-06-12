variable "cluster_name" {
  type        = string
  description = "The name of the VKE cluster"
}

variable "cluster_description" {
  type        = string
  description = "The description of the VKE cluster"
  default     = "Managed by Terraform"
}

variable "delete_protection_enabled" {
  type    = bool
  default = false
}

variable "node_subnet_ids" {
  type = list(string)
}

variable "pod_subnet_ids" {
  type = list(string)
}

variable "api_server_public_access_enabled" {
  type    = bool
  default = true
}

variable "service_cidr" {
  type    = string
  default = "172.19.0.0/20"
}

variable "instance_types" {
  type    = list(string)
  default = ["ecs.g3a.large"]
}

variable "min_nodes" {
  type    = number
  default = 1
}

variable "max_nodes" {
  type    = number
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_password" {
  type        = string
  description = "Base64 encoded password for node login"
  sensitive   = true
}
