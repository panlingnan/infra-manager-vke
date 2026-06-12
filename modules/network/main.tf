locals {
  tags_list = [for k, v in var.tags : { key = k, value = v }]
}

resource "volcenginecc_vpc_vpc" "main" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr
  tags       = local.tags_list
}

resource "volcenginecc_vpc_subnet" "node_subnet" {
  count       = length(var.node_subnet_cidrs)
  vpc_id      = volcenginecc_vpc_vpc.main.id
  subnet_name = "${var.vpc_name}-node-subnet-${count.index}"
  cidr_block  = var.node_subnet_cidrs[count.index]
  zone_id     = var.zones[count.index]
  tags        = local.tags_list
}

resource "volcenginecc_vpc_subnet" "pod_subnet" {
  count       = length(var.pod_subnet_cidrs)
  vpc_id      = volcenginecc_vpc_vpc.main.id
  subnet_name = "${var.vpc_name}-pod-subnet-${count.index}"
  cidr_block  = var.pod_subnet_cidrs[count.index]
  zone_id     = var.zones[count.index]
  tags        = local.tags_list
}

resource "volcenginecc_natgateway_ngw" "nat_gateway" {
  nat_gateway_name = "${var.vpc_name}-nat"
  vpc_id           = volcenginecc_vpc_vpc.main.id
  subnet_id        = volcenginecc_vpc_subnet.node_subnet[0].id
  spec             = var.nat_spec
  billing_type     = 2
  tags             = local.tags_list
}

resource "volcenginecc_vpc_eip" "eip" {
  name          = "${var.vpc_name}-nat-eip"
  billing_type  = 3
  bandwidth     = var.eip_bandwidth
  instance_id   = volcenginecc_natgateway_ngw.nat_gateway.id
  instance_type = "Nat"
  tags          = local.tags_list
}

# Serialize SNAT entry creation to avoid conflict
resource "volcenginecc_natgateway_snatentry" "node_snat" {
  count          = length(var.node_subnet_cidrs)
  nat_gateway_id = volcenginecc_natgateway_ngw.nat_gateway.id
  subnet_id      = volcenginecc_vpc_subnet.node_subnet[count.index].id
  eip_id         = volcenginecc_vpc_eip.eip.id

  depends_on = [
    volcenginecc_vpc_eip.eip
  ]
}

resource "volcenginecc_natgateway_snatentry" "pod_snat" {
  count          = length(var.pod_subnet_cidrs)
  nat_gateway_id = volcenginecc_natgateway_ngw.nat_gateway.id
  subnet_id      = volcenginecc_vpc_subnet.pod_subnet[count.index].id
  eip_id         = volcenginecc_vpc_eip.eip.id

  depends_on = [
    volcenginecc_natgateway_snatentry.node_snat
  ]
}
