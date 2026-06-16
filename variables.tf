variable "region" {
  type        = string
  description = "The region where resources will be created"
  default     = "cn-guilin-boe"
}

variable "cluster_name" {
  type        = string
  description = "The name of the VKE cluster and related resources"
  default     = "enterprise-vke"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "zones" {
  type        = list(string)
  description = "The availability zones for subnets"
  default     = ["cn-guilin-a", "cn-guilin-c"]
}

variable "node_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks for the Node subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "pod_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks for the Pod subnets"
  default     = ["10.0.16.0/20", "10.0.32.0/20"]
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types for the VKE node pool"
  default     = ["ecs.g3a.large"]
}

variable "node_password" {
  type        = string
  description = "Base64 encoded password for node login"
  sensitive   = true
  default     = "VmtlQDEyMzQ1Njc4" # Vke@12345678 in base64
}
