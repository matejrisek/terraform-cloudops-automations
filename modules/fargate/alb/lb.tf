resource "aws_alb" "ecs_cluster_alb" {
  name            = "${var.fargate_clstr_name}-alb"
  internal        = true
  security_groups = var.alb_security_group_id_list
  subnets         = var.vpc_private_subnets_compute_list
  load_balancer_type = "application"
  enable_cross_zone_load_balancing = true
  idle_timeout = 600
}
