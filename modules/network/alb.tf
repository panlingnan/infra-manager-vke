resource "volcenginecc_alb_load_balancer" "alb" {
  load_balancer_name = "${var.vpc_name}-alb"
  vpc_id             = volcenginecc_vpc_vpc.main.id
  type               = "public"

  zone_mappings = [
    for i in range(length(var.zones)) : {
      subnet_id = volcenginecc_vpc_subnet.node_subnet[i].id
      zone_id   = var.zones[i]
    }
  ]

  tags = local.tags_list
}
