locals {
  tags_list = [for k, v in var.tags : { key = k, value = v }]
}

resource "volcenginecc_vke_cluster" "main" {
  name                      = var.cluster_name
  description               = var.cluster_description
  delete_protection_enabled = var.delete_protection_enabled

  cluster_config = {
    subnet_ids                       = var.node_subnet_ids
    api_server_public_access_enabled = var.api_server_public_access_enabled
  }

  pods_config = {
    pod_network_mode = "VpcCniShared"
    vpc_cni_config = {
      subnet_ids = var.pod_subnet_ids
    }
  }

  services_config = {
    service_cidrsv_4 = [var.service_cidr]
  }

  tags = local.tags_list
}

resource "volcenginecc_vke_node_pool" "main" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "${var.cluster_name}-pool"

  node_config = {
    instance_type_ids = var.instance_types
    subnet_ids        = var.node_subnet_ids
    tags              = local.tags_list
    security = {
      login = {
        password = var.node_password
      }
    }
  }

  auto_scaling = {
    enabled          = true
    min_replicas     = var.min_nodes
    desired_replicas = var.min_nodes
    max_replicas     = var.max_nodes
  }
}

resource "volcenginecc_vke_addon" "prometheus" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "prometheus-agent"
}

resource "volcenginecc_vke_addon" "log_collector" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "log-collector"
}

resource "volcenginecc_vke_addon" "npd" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "node-problem-detector"
}

resource "volcenginecc_vke_addon" "alb_ingress" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "alb-ingress-controller"
}

resource "volcenginecc_vke_addon" "csi" {
  cluster_id = volcenginecc_vke_cluster.main.id
  name       = "csi-ebs"
}
