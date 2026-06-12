module "network" {
  source = "./modules/network"

  vpc_name          = var.cluster_name
  vpc_cidr          = var.vpc_cidr
  zones             = var.zones
  node_subnet_cidrs = var.node_subnet_cidrs
  pod_subnet_cidrs  = var.pod_subnet_cidrs
  tags              = local.common_tags
}

module "vke" {
  source = "./modules/vke"

  cluster_name    = var.cluster_name
  node_subnet_ids = module.network.node_subnet_ids
  pod_subnet_ids  = module.network.pod_subnet_ids
  instance_types  = var.instance_types
  node_password   = var.node_password
  tags            = local.common_tags
}
