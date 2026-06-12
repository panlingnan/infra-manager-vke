variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = "vke-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "node_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Node subnets"
}

variable "pod_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for Pod subnets"
}

variable "eip_bandwidth" {
  type        = number
  description = "Bandwidth of EIP"
  default     = 100
}

variable "nat_spec" {
  type        = string
  description = "Specification of NAT Gateway"
  default     = "Small"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default     = {}
}
