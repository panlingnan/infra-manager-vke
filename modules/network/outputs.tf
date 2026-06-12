output "vpc_id" {
  value = volcenginecc_vpc_vpc.main.id
}

output "node_subnet_ids" {
  value = volcenginecc_vpc_subnet.node_subnet[*].id
}

output "pod_subnet_ids" {
  value = volcenginecc_vpc_subnet.pod_subnet[*].id
}

output "alb_id" {
  value = volcenginecc_alb_load_balancer.alb.id
}
