output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "cluster_id" {
  description = "The ID of the VKE cluster"
  value       = module.vke.cluster_id
}
