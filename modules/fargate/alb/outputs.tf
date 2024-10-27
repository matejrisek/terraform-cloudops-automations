output "ecs_lb_blue_target_group_name" {
  value = aws_alb_target_group.ecs_blue_target_group.name
}

output "ecs_lb_green_target_group_name" {
  value = aws_alb_target_group.ecs_green_target_group.name
}

output "ecs_lb_blue_target_group_id" {
  value = aws_alb_target_group.ecs_blue_target_group.id
}

output "ecs_lb_blue_target_group_arn" {
  value = aws_alb_target_group.ecs_blue_target_group.arn
}

output "ecs_main_listener_arn" {
  value = aws_alb_listener.ecs_alb_https_blue_listener.arn
}

output "ecs_test_listener_arn" {
  value = aws_alb_listener.ecs_alb_https_green_listener.arn
}

output "loadbalancer_dns" {
  value = aws_alb.ecs_cluster_alb.dns_name
}

output "loadbalancer_name" {
  value = aws_alb.ecs_cluster_alb.name
}
